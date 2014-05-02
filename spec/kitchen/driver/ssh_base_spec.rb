# -*- encoding: utf-8 -*-
#
# Author:: John Bellone (<jbellone@bloomberg.net>)
#
# Copyright (C) 2014, Bloomberg Finance L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require_relative '../../spec_helper'
require 'logger'
require 'stringio'
require 'kitchen'

describe Kitchen::Driver::SSHBase do
  let(:logged_output) { StringIO.new }
  let(:logger) { Logger.new(logged_output) }
  let(:instance) { stub(name: 'foo', logger: logger, to_str: 'instance') }

  describe 'when setting environment variable for proxies' do
    let(:config) do
      {
       http_proxy: 'proxy.opscode.com:80',
       https_proxy: 'proxy.opscode.com:82',
       no_proxy: 'localhost,127.0.0.1',
      }
    end

    let(:driver) do
      d = Kitchen::Driver::SSHBase.new(config)
      d.instance = instance
      d
    end

    it 'driver[:http_proxy] is correct' do
      driver[:http_proxy].must_equal 'proxy.opscode.com:80'
    end

    it 'driver[:https_proxy] is correct' do
      driver[:https_proxy].must_equal 'proxy.opscode.com:82'
    end

    it 'driver[:http_proxy] is correct' do
      driver[:no_proxy].must_equal 'localhost,127.0.0.1'
    end
  end
end
