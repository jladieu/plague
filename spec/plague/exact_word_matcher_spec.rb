require 'spec_helper'

describe Plague::ExactWordMatcher do

  before(:each) do
    @matcher = Plague::ExactWordMatcher.new(:num_words => 3)
  end

  it 'should allow num_words to be configured at initialization' do
    Plague::ExactWordMatcher.new(:num_words => 4).num_words.should == 4
  end

  describe '#tokenize' do
    it 'should convert a document into lowercase words without punctuation' do
      @matcher.tokenize('123 4 5,,, The quick brown fox ate some sweet, sweet food.  MMM it wasn\'t bad at all!').should ==
        ['123', '4', '5', 'the', 'quick', 'brown', 'fox', 'ate', 'some', 'sweet',
         'sweet', 'food', 'mmm', 'it', 'wasnt', 'bad', 'at', 'all']
    end
  end

  describe '#extract_phrases' do
    it 'should create all possible n-element phrases from the provided list' do
      result = Plague::ExactWordMatcher.new(:num_words => 2).extract_phrases(['a', 'b', 'c', 'd', 'e', 'f', 'g'])
      result.should == ['a b', 'b c', 'c d', 'd e', 'e f', 'f g']
    end
  end

  describe "#match?" do
    it 'should accept two document strings and return a list of unique phrases from the first document which have exact overlaps in the second' do
      matches = @matcher.match?(
          'The quick brown fox ate some food.  Specifically, the fox ate some meat.  I went to bed.',
          'Therefore a fox ate some time late in the afternoon.  Later on, it went to bed.')

      matches.size.should == 2
      matches.first.should == 'fox ate some'
      matches.last.should == 'went to bed'
    end
  end

  describe '#match_files?' do
    it 'should do the same thing as match except use two different files as input' do
      matches = @matcher.match_files?(File.join(File.dirname(__FILE__), '../fixtures/candidate.txt'),
                                      File.join(File.dirname(__FILE__), '../fixtures/original.txt'))

      matches.size.should == 2
      matches.first.should == 'fox ate some'
      matches.last.should == 'went to bed'
    end
  end
end
