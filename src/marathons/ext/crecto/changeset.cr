module Crecto::Changeset(T)
  class Changeset(T)
    def to_h
      {
        "valid" => valid?,
        "errors" => errors.reduce({} of String => String) do |acc, error|
          field = error[:field]
          message = error[:message]
          acc[field] = message
          acc
        end
      }
    end
  end
end
