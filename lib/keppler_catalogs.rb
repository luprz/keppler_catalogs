require "keppler_catalogs/engine"

module KepplerCatalogs
	ROUTE_SIDEBAR = true
	# Default way to setup ContactUs. Run rake contact_us:install to create
	# a fresh initializer with all configuration values.
	mattr_accessor :sections
	def self.setup
		yield self
	end
end
