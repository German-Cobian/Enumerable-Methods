require './enumerables.rb'

describe 'Enumerables' do
  let(:array) { %w[german julius cobian mih ndim] }
  let(:num_array) { [1,2,3,4,5] }
  let(:num_array_clone) { num_array.clone }
  let(:num_array2) { [7,5,3,5,2] }

  describe '#my_each' do

    it "works identically to ruby\'s #each method when a block is given" do
    expect(num_array.my_each { |elem| (elem * 5)}).to eq(num_array.each { |i| i.send('*', 5)})
    end

    it "returns an enumerator if no block is given " do
      expect(num_array.my_each).to be_an(Enumerator)
    end

    it 'does not mutate the original array' do
      expect(num_array.my_each{|elt| elt + 1}).to eq(num_array_clone)
    end
  end


  describe 'my_each_with_index' do

    it 'works identically to ruby\'s #each_with_index method when a block is given' do
    expect(num_array.my_each_with_index { |a, i| a + i }).to eq(num_array.each_with_index do |elem, index|
      puts elem + index
      end)
    end
  
    it 'does not mutate the original array' do
      expect(num_array.my_each_with_index{|elt, index| puts elt + index}).to eq(num_array_clone)
    end

    it 'returns and enumerable if no block is given' do
      expect(num_array.my_each_with_index).to be_an(Enumerator)
    end
  end

  describe '#my_select' do
    let(:block) {proc {|element| element > 3}}
    let(:range) { Range.new(0,9) }
    it 'returns an enumerator with elements for which the given block evaluates to true' do
      expect(range.my_select(&block)).to eq(range.select(&block))
    end
    
    it 'returns an enumerator if no block is given' do
      expect(range.my_select).to be_an(Enumerator)
    end

    it 'does not mutate the original array'do
      expect(num_array.my_select {|element| element + 2} ).to eq(num_array_clone)
    end
  end
  
end