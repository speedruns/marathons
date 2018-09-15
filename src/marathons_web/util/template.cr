require "crinja"

module Template
  extend self

  TEMPLATE_DIR = File.join(__DIR__, "..", "templates")
  ENGINE = Crinja.new(loader: Crinja::Loader::FileSystemLoader.new(TEMPLATE_DIR))

  def render(template, **locals)
    template = ENGINE.get_template(template)
    template.render(locals)
  end

  def render(template, *, locals)
    template = ENGINE.get_template(template)
    template.render(locals)
  end
end