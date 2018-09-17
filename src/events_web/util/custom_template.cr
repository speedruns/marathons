require "crinja"

module CustomTemplate
  extend self

  TEMPLATE_DIR = File.join("public/custom_assets/")
  ENGINE = Crinja.new(loader: Crinja::Loader::FileSystemLoader.new(TEMPLATE_DIR))

  def render(conn, template, **locals)
    template = ENGINE.get_template(asset_path(conn, template))
    conn.response.puts(template.render(locals))
  end

  def render(conn, template, *, locals)
    template = ENGINE.get_template(asset_path(conn, template))
    conn.response.puts(template.render(locals))
  end

  private def asset_path(conn, file)
    "#{conn.event.id}/#{file}"
  end
end
