# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the 


locals {
  env = "dev"
}

provider "google" {
  project = "${var.project}"
}

resource "google_storage_bucket" "bucket-for-state" {
  name = "customercloud-deployment-terraform-state-alek"
  location = "EU"
  uniform_bucket_level_access = true 
}

module "vpc" {
  source  = "../../modules/vpc"
  project = "${var.project}"
  env     = "${local.env}"   
}

# resource "google_project_service" "project" {
#   project = "${var.project}"
#   service   = "cloudbilling.googleapis.com"
# }

#auto created bucket, vpc, clean up, move to test/prod
#required persmissions: serviceusage.services.enable

# is it possible to create new bucket and store state there within first run of configuration file? or you must update it?

# 1. manually create bucket 
# 2. enable compute engine API to create VPC (missing permission: serviceusage.services.enable) (are we able to add them ourselfs?)