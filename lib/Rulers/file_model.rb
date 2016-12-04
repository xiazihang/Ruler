require 'multi_json'

module Rulers
  module Model
    class FileModel
      def initialize(filename)
        @filename = filename
        basename = File.split(filename)[-1]
        @id = File.basename(basename, ".json").to_i

        @hash = MultiJson.load(File.read(filename))
      end

      def [](attr)
        @hash[attr.to_s]
      end

      def []=(attr, value)
        @hash[attr.to_s] = value
      end

      class << self
        def inherited subclass
          subclass.class_eval do
            folder_name = subclass.to_s.downcase

            define_singleton_method :find do |id|
              begin
                FileModel.new("db/#{folder_name}/#{id}.json")
              rescue
                nil
              end
            end

            define_singleton_method :all do
              Dir["db/#{folder_name}/*.json"].map{|f| FileModel.new(f)}
            end

            define_singleton_method :create do |attr|
              new_json = {}
              new_json["submitter"]   = attr["submitter"] || ""
              new_json["quote"]       = attr["quote"] || ""
              new_json["attribution"] = attr["attribution"] || ""
              latest_id = Dir["db/#{folder_name}/*.json"].map{|f| f.split("/")[-1].to_i}.max
              new_id = latest_id + 1

              File.open("db/#{folder_name}/#{new_id}.json", "w") do |json|
                json.write <<-JSONCONTENT
                {
                  "submitter": "#{new_json['submitter']}",
                  "quote": "#{new_json['quote']}",
                  "attribution": "#{new_json['attribution']}"
                }
                JSONCONTENT
              end

              FileModel.new("db/#{folder_name}/#{new_id}.json")
            end
          end
        end
      end
    end
  end
end
