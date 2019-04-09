# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: vagrant.proto for package 'vagrant.proto'

require 'grpc'
require_relative 'vagrant_pb'

module Vagrant
  module Proto
    module IO
      class Service

        include GRPC::GenericService

        self.marshal_class_method = :encode
        self.unmarshal_class_method = :decode
        self.service_name = 'vagrant.proto.IO'

        rpc :Read, Identifier, Content
        rpc :Write, Content, WriteResponse
      end

      Stub = Service.rpc_stub_class
    end
    module GuestCapabilities
      class Service

        include GRPC::GenericService

        self.marshal_class_method = :encode
        self.unmarshal_class_method = :decode
        self.service_name = 'vagrant.proto.GuestCapabilities'

        rpc :GuestCapabilities, Empty, SystemCapabilityList
        rpc :GuestCapability, GuestCapabilityRequest, GenericResponse
        # IO helpers for streaming (copied from Stream service)
        rpc :Read, Identifier, Content
        rpc :Write, Content, WriteResponse
      end

      Stub = Service.rpc_stub_class
    end
    module HostCapabilities
      class Service

        include GRPC::GenericService

        self.marshal_class_method = :encode
        self.unmarshal_class_method = :decode
        self.service_name = 'vagrant.proto.HostCapabilities'

        rpc :HostCapabilities, Empty, SystemCapabilityList
        rpc :HostCapability, HostCapabilityRequest, GenericResponse
        # IO helpers for streaming (copied from Stream service)
        rpc :Read, Identifier, Content
        rpc :Write, Content, WriteResponse
      end

      Stub = Service.rpc_stub_class
    end
    module ProviderCapabilities
      class Service

        include GRPC::GenericService

        self.marshal_class_method = :encode
        self.unmarshal_class_method = :decode
        self.service_name = 'vagrant.proto.ProviderCapabilities'

        rpc :ProviderCapabilities, Empty, ProviderCapabilityList
        rpc :ProviderCapability, ProviderCapabilityRequest, GenericResponse
        # IO helpers for streaming (copied from Stream service)
        rpc :Read, Identifier, Content
        rpc :Write, Content, WriteResponse
      end

      Stub = Service.rpc_stub_class
    end
    module Config
      class Service

        include GRPC::GenericService

        self.marshal_class_method = :encode
        self.unmarshal_class_method = :decode
        self.service_name = 'vagrant.proto.Config'

        rpc :ConfigAttributes, Empty, ListResponse
        rpc :ConfigLoad, Configuration, Configuration
        rpc :ConfigValidate, Configuration, ListResponse
        rpc :ConfigFinalize, Configuration, Configuration
        # IO helpers for streaming (copied from Stream service)
        rpc :Read, Identifier, Content
        rpc :Write, Content, WriteResponse
      end

      Stub = Service.rpc_stub_class
    end
    module SyncedFolder
      class Service

        include GRPC::GenericService

        self.marshal_class_method = :encode
        self.unmarshal_class_method = :decode
        self.service_name = 'vagrant.proto.SyncedFolder'

        rpc :Cleanup, SyncedFolders, Empty
        rpc :Disable, SyncedFolders, Empty
        rpc :Enable, SyncedFolders, Empty
        rpc :Info, Empty, PluginInfo
        rpc :IsUsable, Machine, Valid
        rpc :Name, Empty, Identifier
        rpc :Prepare, SyncedFolders, Empty
        # IO helpers for streaming (copied from Stream service)
        rpc :Read, Identifier, Content
        rpc :Write, Content, WriteResponse
        # Guest capabilities helpers (copied from GuestCapabilities service)
        rpc :GuestCapabilities, Empty, SystemCapabilityList
        rpc :GuestCapability, GuestCapabilityRequest, GenericResponse
        # Host capabilities helpers (copied from GuestCapabilities service)
        rpc :HostCapabilities, Empty, SystemCapabilityList
        rpc :HostCapability, HostCapabilityRequest, GenericResponse
      end

      Stub = Service.rpc_stub_class
    end
    module Provider
      class Service

        include GRPC::GenericService

        self.marshal_class_method = :encode
        self.unmarshal_class_method = :decode
        self.service_name = 'vagrant.proto.Provider'

        rpc :Action, GenericAction, ListResponse
        rpc :Info, Empty, PluginInfo
        rpc :IsInstalled, Machine, Valid
        rpc :IsUsable, Machine, Valid
        rpc :MachineIdChanged, Machine, Machine
        rpc :Name, Empty, Identifier
        rpc :RunAction, ExecuteAction, GenericResponse
        rpc :SshInfo, Machine, MachineSshInfo
        rpc :State, Machine, MachineState
        # IO helpers for streaming (copied from Stream service)
        rpc :Read, Identifier, Content
        rpc :Write, Content, WriteResponse
        # Config helpers (copied from Config service)
        rpc :ConfigAttributes, Empty, ListResponse
        rpc :ConfigLoad, Configuration, Configuration
        rpc :ConfigValidate, Configuration, ListResponse
        rpc :ConfigFinalize, Configuration, Configuration
        # Guest capabilities helpers (copied from GuestCapabilities service)
        rpc :GuestCapabilities, Empty, SystemCapabilityList
        rpc :GuestCapability, GuestCapabilityRequest, GenericResponse
        # Host capabilities helpers (copied from HostCapabilities service)
        rpc :HostCapabilities, Empty, SystemCapabilityList
        rpc :HostCapability, HostCapabilityRequest, GenericResponse
        # Provider capabilities helpers (copied from ProviderCapabilities service)
        rpc :ProviderCapabilities, Empty, ProviderCapabilityList
        rpc :ProviderCapability, ProviderCapabilityRequest, GenericResponse
      end

      Stub = Service.rpc_stub_class
    end
  end
end

require 'logger'

# DebugIsTruncated extends the default Logger to truncate debug messages
class DebugIsTruncated < Logger
  def debug(s)
    super(truncate(s, 1024))
  end

  # Truncates a given +text+ after a given <tt>length</tt> if +text+ is longer than <tt>length</tt>:
  #
  #   'Once upon a time in a world far far away'.truncate(27)
  #   # => "Once upon a time in a wo..."
  #
  # Pass a string or regexp <tt>:separator</tt> to truncate +text+ at a natural break:
  #
  #   'Once upon a time in a world far far away'.truncate(27, separator: ' ')
  #   # => "Once upon a time in a..."
  #
  #   'Once upon a time in a world far far away'.truncate(27, separator: /\s/)
  #   # => "Once upon a time in a..."
  #
  # The last characters will be replaced with the <tt>:omission</tt> string (defaults to "...")
  # for a total length not exceeding <tt>length</tt>:
  #
  #   'And they found that many people were sleeping better.'.truncate(25, omission: '... (continued)')
  #   # => "And they f... (continued)"
  def truncate(s, truncate_at, options = {})
    return s unless s.length > truncate_at
    omission = options[:omission] || '...'
    with_extra_room = truncate_at - omission.length
    stop = \
      if options[:separator]
        rindex(options[:separator], with_extra_room) || with_extra_room
      else
        with_extra_room
      end
    "#{s[0, stop]}#{omission}"
  end
end

# RubyLogger defines a logger for gRPC based on the standard ruby logger.
module RubyLogger
  def logger
    LOGGER
  end

  LOGGER = DebugIsTruncated.new(STDOUT)
  LOGGER.level = Logger::DEBUG
end

# GRPC is the general RPC module
module GRPC
  # Inject the noop #logger if no module-level logger method has been injected.
  extend RubyLogger
end
