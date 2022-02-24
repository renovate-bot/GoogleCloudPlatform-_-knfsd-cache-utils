/*
 Copyright 2021 Google LLC

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

locals {
  mount_labels = {
    "server": "Source NFS server of the mount",
    "path": "Source NFS path of the mount"
  }
}

resource "google_monitoring_metric_descriptor" "dentry_cache_active_objects" {
  description  = "The number of active objects in the Linux Dentry Cache"
  display_name = "Dentry Cache Active Objects"
  type         = "custom.googleapis.com/knfsd/dentry_cache_active_objects"
  metric_kind  = "GAUGE"
  value_type   = "INT64"
  unit         = "1"
}

resource "google_monitoring_metric_descriptor" "dentry_cache_objsize" {
  description  = "The total size of the objects in the Linux Dentry Cache"
  display_name = "Dentry Cache Object Size"
  type         = "custom.googleapis.com/knfsd/dentry_cache_objsize"
  metric_kind  = "GAUGE"
  value_type   = "INT64"
  unit         = "By"
}

resource "google_monitoring_metric_descriptor" "nfs_inode_cache_active_objects" {
  description  = "The number of active objects in the Linux NFS inode Cache"
  display_name = "NFS inode Cache Cache Active Objects"
  type         = "custom.googleapis.com/knfsd/nfs_inode_cache_active_objects"
  metric_kind  = "GAUGE"
  value_type   = "INT64"
  unit         = "1"
}

resource "google_monitoring_metric_descriptor" "nfs_inode_cache_objsize" {
  description  = "The total size of the objects in the Linux NFS inode Cache"
  display_name = "NFS inode Cache Object Size"
  type         = "custom.googleapis.com/knfsd/nfs_inode_cache_objsize"
  metric_kind  = "GAUGE"
  value_type   = "INT64"
  unit         = "By"
}

resource "google_monitoring_metric_descriptor" "nfsiostat_mount_read_exe" {
  description  = "The average read operation EXE per NFS client mount over the past 60 seconds (Knfsd --> Source Filer)"
  display_name = "nfsiostat Mount Read EXE"
  type         = "custom.googleapis.com/knfsd/nfsiostat_mount_read_exe"
  metric_kind  = "GAUGE"
  value_type   = "DOUBLE"
  unit         = "ms"

  dynamic "labels" {
    for_each = local.mount_labels
    content {
      key = labels.key
      value_type = "STRING"
      description = labels.value
    }
  }
}

resource "google_monitoring_metric_descriptor" "nfsiostat_mount_read_rtt" {
  description  = "The average read operation RTT per NFS client mount over the past 60 seconds (Knfsd --> Source Filer)"
  display_name = "nfsiostat Mount Read RTT"
  type         = "custom.googleapis.com/knfsd/nfsiostat_mount_read_rtt"
  metric_kind  = "GAUGE"
  value_type   = "DOUBLE"
  unit         = "ms"

  dynamic "labels" {
    for_each = local.mount_labels
    content {
      key = labels.key
      value_type = "STRING"
      description = labels.value
    }
  }
}

resource "google_monitoring_metric_descriptor" "nfsiostat_mount_write_exe" {
  description  = "The average write operation EXE per NFS client mount over the past 60 seconds (Knfsd --> Source Filer)"
  display_name = "nfsiostat Mount Write EXE"
  type         = "custom.googleapis.com/knfsd/nfsiostat_mount_write_exe"
  metric_kind  = "GAUGE"
  value_type   = "DOUBLE"
  unit         = "ms"

  dynamic "labels" {
    for_each = local.mount_labels
    content {
      key = labels.key
      value_type = "STRING"
      description = labels.value
    }
  }
}

resource "google_monitoring_metric_descriptor" "nfsiostat_mount_write_rtt" {
  description  = "The average write operation RTT per NFS client mount over the past 60 seconds (Knfsd --> Source Filer)"
  display_name = "nfsiostat Mount Write RTT"
  type         = "custom.googleapis.com/knfsd/nfsiostat_mount_write_rtt"
  metric_kind  = "GAUGE"
  value_type   = "DOUBLE"
  unit         = "ms"

  dynamic "labels" {
    for_each = local.mount_labels
    content {
      key = labels.key
      value_type = "STRING"
      description = labels.value
    }
  }
}

resource "google_monitoring_metric_descriptor" "nfsiostat_ops_per_second" {
  description  = "The number of NFS operations per second per NFS client mount over the past 60 seconds (Knfsd --> Source Filer)"
  display_name = "nfsiostat Mount Operations Per Second"
  type         = "custom.googleapis.com/knfsd/nfsiostat_ops_per_second"
  metric_kind  = "GAUGE"
  value_type   = "DOUBLE"
  unit         = "1"

  dynamic "labels" {
    for_each = local.mount_labels
    content {
      key = labels.key
      value_type = "STRING"
      description = labels.value
    }
  }
}

resource "google_monitoring_metric_descriptor" "nfsiostat_rpc_backlog" {
  description  = "The RPC Backlog per NFS client mount over the past 60 seconds (Knfsd --> Source Filer)"
  display_name = "nfsiostat Mount RPC Backlog"
  type         = "custom.googleapis.com/knfsd/nfsiostat_rpc_backlog"
  metric_kind  = "GAUGE"
  value_type   = "DOUBLE"
  unit         = "1"

  dynamic "labels" {
    for_each = local.mount_labels
    content {
      key = labels.key
      value_type = "STRING"
      description = labels.value
    }
  }
}

resource "google_monitoring_metric_descriptor" "nfs_connections" {
  description  = "The number of NFS Clients connected to the Knfsd filer (used for autoscaling)"
  display_name = "Knfsd NFS Clients Connected"
  type         = "custom.googleapis.com/knfsd/nfs_connections"
  metric_kind  = "GAUGE"
  value_type   = "INT64"
  unit         = "1"
}

resource "google_monitoring_metric_descriptor" "fscache_oldest_file" {
  description  = "Age of the oldest file in FS-Cache"
  display_name = "Age of the oldest file in FS-Cache"
  type         = "custom.googleapis.com/knfsd/fscache_oldest_file"
  metric_kind  = "GAUGE"
  value_type   = "INT64"
  unit         = "s"
}

resource "google_monitoring_dashboard" "knfsd-monitoring-dashboard" {
  dashboard_json = file("dashboard/dashboard.json")
}
