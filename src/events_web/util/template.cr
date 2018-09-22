require "crinja"

module Template
  extend self

  TEMPLATE_DIR = File.join(__DIR__, "..", "templates")
  ENGINE = Crinja.new(loader: Crinja::Loader::FileSystemLoader.new(TEMPLATE_DIR))

  def render(conn, template, locals={} of String => String)
    locals = locals.merge({
      "conn" => conn_to_h(conn)
    })
    template = ENGINE.get_template(template)
    conn.response.puts(template.render(locals))
  end

  private def conn_to_h(conn)
    {
      "user" => conn.current_user? ? conn.current_user.to_h : nil,
      "session" => conn.session? ? conn.session.to_h : nil
    }
  end
end
