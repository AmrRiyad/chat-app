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
    module Actions
      # Open a point in time that can be used in subsequent searches
      #
      # @option arguments [List] :index A comma-separated list of index names to open point in time; use `_all` or empty string to perform the operation on all indices
      # @option arguments [String] :preference Specify the node or shard the operation should be performed on (default: random)
      # @option arguments [String] :routing Specific routing value
      # @option arguments [Boolean] :ignore_unavailable Whether specified concrete indices should be ignored when unavailable (missing or closed)
      # @option arguments [String] :expand_wildcards Whether to expand wildcard expression to concrete indices that are open, closed or both. (options: open, closed, hidden, none, all)
      # @option arguments [String] :keep_alive Specific the time to live for the point in time (*Required*)
      # @option arguments [Boolean] :allow_partial_search_results Specify whether to tolerate shards missing when creating the point-in-time, or otherwise throw an exception. (default: false)
      # @option arguments [Hash] :headers Custom HTTP headers
      # @option arguments [Hash] :body An index_filter specified with the Query DSL
      #
      # @see https://www.elastic.co/guide/en/elasticsearch/reference/8.17/point-in-time-api.html
      #
      def open_point_in_time(arguments = {})
        request_opts = { endpoint: arguments[:endpoint] || 'open_point_in_time' }

        defined_params = [:index].each_with_object({}) do |variable, set_variables|
          set_variables[variable] = arguments[variable] if arguments.key?(variable)
        end
        request_opts[:defined_params] = defined_params unless defined_params.empty?

        raise ArgumentError, "Required argument 'index' missing" unless arguments[:index]

        arguments = arguments.clone
        headers = arguments.delete(:headers) || {}

        body   = arguments.delete(:body)

        _index = arguments.delete(:index)

        method = Elasticsearch::API::HTTP_POST
        path   = "#{Utils.__listify(_index)}/_pit"
        params = Utils.process_params(arguments)

        Elasticsearch::API::Response.new(
          perform_request(method, path, params, body, headers, request_opts)
        )
      end
    end
  end
end
