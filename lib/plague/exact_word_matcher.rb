module Plague
  class ExactWordMatcher
    attr_accessor :num_words

    def initialize(options = {})
      self.num_words = options[:num_words]
    end

    def match?(original, candidate)
      original_phrases = split_into_phrases(original)
      candidate_phrases = split_into_phrases(candidate)

      original_phrases & candidate_phrases
    end

    def match_files?(original, candidate)
      match?(load_file_contents(original), load_file_contents(candidate))
    end

    def load_file_contents(filename)
      puts "Loading contents of: #{filename}"
      file = File.open(filename, 'rb')
      begin
        return file.read
      ensure
        puts "Done reading #{filename}."
        file.close
      end
    end

    def tokenize(document)
      puts "Tokenizing..."
      document.downcase.gsub(/[^a-z0-9 ]/, '').squeeze(' ').split
    end

    def extract_phrases(tokenized_document)
      puts "Extracting #{num_words}-word phrases from tokenized document."
      [].tap do |phrases|
        while (current_phrase = tokenized_document.take(num_words)).size == num_words
          phrases << current_phrase.join(' ')
          print '.'
          tokenized_document = tokenized_document.drop(1)
        end
      end
    end

    private

    def split_into_phrases(document)
      extract_phrases(tokenize(document)).uniq
    end
  end
end