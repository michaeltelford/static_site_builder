module StaticSiteBuilder
  class Renderer
    def initialize
    end

    def render
      raise "Missing `render` method in sub-class"
    end
  end
end
