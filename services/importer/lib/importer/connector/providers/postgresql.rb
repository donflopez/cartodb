# encoding: utf-8

require_relative './odbc'

module CartoDB
  module Importer2
    class Connector

      # PostgreSQL provider using [psqlODBC](https://odbc.postgresql.org/) driver
      #
      # For complete list of parameters, see these references:
      # * https://odbc.postgresql.org/docs/config-opt.html
      # * https://git.postgresql.org/gitweb/?p=psqlodbc.git;a=blob;f=dlg_specific.c;h=28ebf54b5a87fdfe1f6091ccab9c610edb5556bb;hb=HEAD#l529
      # * https://odbc.postgresql.org/docs/config.html
      #
      class PostgreSQLProvider < OdbcProvider

        private

        def fixed_connection_attributes
          {
            Driver:               'PostgreSQL Unicode',
            ByteaAsLongVarBinary: 1,
            MaxVarcharSize:       256,
            BoolAsChar:           0
          }
        end

        def required_connection_attributes
          {
            server:   :Server,
            database: :Database,
            username: :UID
          }
        end

        def optional_connection_attributes
          {
            port: { Port: 5432 },
            password: { PWD: nil }
          }
        end

        def non_connection_parameters
          # Default remote schema
          super.reverse_merge(schema: 'public')
        end
      end
    end
  end
end
