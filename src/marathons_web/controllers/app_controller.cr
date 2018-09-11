module AppController
  macro extended
    extend self

    CON_VIEW_MODULE = {{@type.name.gsub(/Controller/, "View")}}

    macro render(view, locals)
      CON_VIEW_MODULE.\{{view.id}}(\{{locals}})
    end
  end
end
