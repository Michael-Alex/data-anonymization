module DataAnon
  module Strategy
    module Field


      class RandomAddress  < GeojsonBase

        def initialize file_path
          @values = DataAnon::Utils::GeojsonParser.address(file_path)
        end

      end


    end
  end
end