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
    module DanglingIndices
      module Actions
        # Imports the specified dangling index
        #
        # @option arguments [String] :index_uuid The UUID of the dangling index
        # @option arguments [Boolean] :accept_data_loss Must be set to true in order to import the dangling index
        # @option arguments [Time] :timeout Explicit operation timeout
        # @option arguments [Time] :master_timeout Specify timeout for connection to master
        # @option arguments [Hash] :headers Custom HTTP headers
        #
        # @see https://www.elastic.co/guide/en/elasticsearch/reference/8.17/modules-gateway-dangling-indices.html
        #
        def import_dangling_index(arguments = {})
          request_opts = { endpoint: arguments[:endpoint] || 'dangling_indices.import_dangling_index' }

          defined_params = [:index_uuid].each_with_object({}) do |variable, set_variables|
            set_variables[variable] = arguments[variable] if arguments.key?(variable)
          end
          request_opts[:defined_params] = defined_params unless defined_params.empty?

          raise ArgumentError, "Required argument 'index_uuid' missing" unless arguments[:index_uuid]

          arguments = arguments.clone
          headers = arguments.delete(:headers) || {}

          body = nil

          _index_uuid = arguments.delete(:index_uuid)

          method = Elasticsearch::API::HTTP_POST
          path   = "_dangling/#{Utils.__listify(_index_uuid)}"
          params = Utils.process_params(arguments)

          Elasticsearch::API::Response.new(
            perform_request(method, path, params, body, headers, request_opts)
          )
        end
      end
    end
  end
end
