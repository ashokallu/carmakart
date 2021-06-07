module Carmakart
  class NgramGenerator

    module Types
      Uni_grams = "uni_grams"
      Bi_grams = "bi_grams"
      Tri_grams = "tri_grams"
    end

    attr_accessor :text, :normalized_text_array

    attr_reader :uni_grams, :bi_grams, :tri_grams, :all_n_grams

    def initialize(text)
      self.text = text
      self.normalized_text_array = normalize_text(self.text)
    end

    def generate_uni_grams
      @uni_grams = generate_n_grams(1)
    end

    def generate_bi_grams
      @bi_grams = generate_n_grams(2)
    end

    def generate_tri_grams
      @tri_grams = generate_n_grams(3)
    end

    def generate_all_n_grams
      @all_n_grams ||= {
        Types::Uni_grams => generate_uni_grams.entries,
        Types::Bi_grams => generate_bi_grams.entries,
        Types::Tri_grams => generate_tri_grams.entries,
      }
    end

    private

      def normalize_text(text)
        text.downcase.scan(/[a-z]+/)
      end

      def generate_n_grams(n)
        size = normalized_text_array.count
        n_grams = (size - (n - 1)).times.map do |idx|
          normalized_text_array[idx, n].join(" ")
        end
        Set[*n_grams]
      end
  end
end