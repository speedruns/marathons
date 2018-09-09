module Events
  class Submission::Option < Crecto::Model
    schema "ev_sub_options" do
      belongs_to :submission, Submission

      field :name, String
      field :type, String
      field :string, String
      field :int, Int64
      field :float, Float64
      field :boolean, Bool
    end


    def value(value)
      case self.type
      when "string"   then self.string
      when "int"      then self.int
      when "float"    then self.float
      when "boolean"  then self.boolean
      end
    end

    def value=(value)
      case self.type
      when "string"   then self.string  = value
      when "int"      then self.int     = value
      when "float"    then self.float   = value
      when "boolean"  then self.boolean = value
      end
    end
  end
end
