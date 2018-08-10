/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  credentials_file_path = "${var.credentials_file_path}"
}

/******************************************
  Provider configuration
 *****************************************/
provider "google" {
  credentials = "${file(local.credentials_file_path)}"
}

/******************************************
  Module pubsub_subscription_iam_binding calling
 *****************************************/
module "subnet_iam_binding" {
  source = "../../"

  subnets = ["${var.subnet_one}", "${var.subnet_two}"]

  mode = "authoritative"

  bindings = {
    "roles/compute.networkUser" = [
      "user:josemanuelt@google.com",
      "group:test_sa_group@lnescidev.com",
    ]

    "roles/compute.networkViewer" = [
      "user:josemanuelt@google.com",
      "group:test_sa_group@lnescidev.com",
    ]
  }
}