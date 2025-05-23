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
    module Indices
      module Actions
        # Returns information about whether a particular alias exists.
        #
        # @option arguments [List] :name A comma-separated list of alias names to return
        # @option arguments [List] :index A comma-separated list of index names to filter aliases
        # @option arguments [Boolean] :ignore_unavailable Whether specified concrete indices should be ignored when unavailable (missing or closed)
        # @option arguments [Boolean] :allow_no_indices Whether to ignore if a wildcard indices expression resolves into no concrete indices. (This includes `_all` string or when no indices have been specified)
        # @option arguments [String] :expand_wildcards Whether to expand wildcard expression to concrete indices that are open, closed or both. (options: open, closed, hidden, none, all)
        # @option arguments [Boolean] :local Return local information, do not retrieve the state from master node (default: false)
        # @option arguments [Hash] :headers Custom HTTP headers
        #
        # @see https://www.elastic.co/guide/en/elasticsearch/reference/8.17/indices-aliases.html
        #
        def exists_alias(arguments = {})
          request_opts = { endpoint: arguments[:endpoint] || 'indices.exists_alias' }

          defined_params = %i[name index].each_with_object({}) do |variable, set_variables|
            set_variables[variable] = arguments[variable] if arguments.key?(variable)
          end
          request_opts[:defined_params] = defined_params unless defined_params.empty?

          raise ArgumentError, "Required argument 'name' missing" unless arguments[:name]

          arguments = arguments.clone
          headers = arguments.delete(:headers) || {}

          body = nil

          _name = arguments.delete(:name)

          _index = arguments.delete(:index)

          method = Elasticsearch::API::HTTP_HEAD
          path   = if _index && _name
                     "#{Utils.__listify(_index)}/_alias/#{Utils.__listify(_name)}"
                   else
                     "_alias/#{Utils.__listify(_name)}"
                   end
          params = Utils.process_params(arguments)

          Utils.__rescue_from_not_found do
            perform_request(method, path, params, body, headers, request_opts).status == 200
          end
        end

        alias exists_alias? exists_alias
      end
    end
  end
end
