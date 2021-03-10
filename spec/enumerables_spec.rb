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

    
  end
end