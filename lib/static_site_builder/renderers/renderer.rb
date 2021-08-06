module StaticSiteBuilder
  # Renderer super class to be inherited from.
  class Renderer
    def initialize
    end

    def render
      raise "Missing `render` method in sub-class"
    end
  end
end
