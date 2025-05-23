# Licensed to Elasticsearch B.V. under one or more contributor
# license agreements. See the NOTICE file distributed with
# this work for additional information regarding copyright
# ownership. Elasticsearch B.V. licenses this file to you under
# the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
# Auto generated from build hash f284cc16f4d4b4289bc679aa1529bb504190fe80
# @see https://github.com/elastic/elasticsearch/tree/main/rest-api-spec
#
module Elasticsearch
  module API
    module Tasks
      module Actions
        # Cancels a task, if it can be cancelled through an API.
        # This functionality is Experimental and may be changed or removed
        # completely in a future release. Elastic will take a best effort approach
        # to fix any issues, but experimental features are not subject to the
        # support SLA of official GA features.
        #
        # @option arguments [String] :task_id Cancel the task with specified task id (node_id:task_number)
        # @option arguments [List] :nodes A comma-separated list of node IDs or names to limit the returned information; use `_local` to return information from the node you're connecting to, leave empty to get information from all nodes
        # @option arguments [List] :actions A comma-separated list of actions that should be cancelled. Leave empty to cancel all.
        # @option arguments [String] :parent_task_id Cancel tasks with specified parent task id (node_id:task_number). Set to -1 to cancel all.
        # @option arguments [Boolean] :wait_for_completion Should the request block until the cancellation of the task and its descendant tasks is completed. Defaults to false
        # @option arguments [Hash] :headers Custom HTTP headers
        #
        # @see https://www.elastic.co/guide/en/elasticsearch/reference/8.17/tasks.html
        #
        def cancel(arguments = {})
          request_opts = { endpoint: arguments[:endpoint] || 'tasks.cancel' }

          defined_params = [:task_id].each_with_object({}) do |variable, set_variables|
            set_variables[variable] = arguments[variable] if arguments.key?(variable)
          end
          request_opts[:defined_params] = defined_params unless defined_params.empty?

          arguments = arguments.clone
          headers = arguments.delete(:headers) || {}

          body = nil

          _task_id = arguments.delete(:task_id)

          method = Elasticsearch::API::HTTP_POST
          path   = if _task_id
                     "_tasks/#{Utils.__listify(_task_id)}/_cancel"
                   else
                     '_tasks/_cancel'
                   end
          params = Utils.process_params(arguments)

          Elasticsearch::API::Response.new(
            perform_request(method, path, params, body, headers, request_opts)
          )
        end
      end
    end
  end
end
