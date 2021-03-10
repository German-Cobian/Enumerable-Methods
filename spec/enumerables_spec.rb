require './enumerables.rb'

describe 'Enumerables' do
  let(:array) { %w[german julius cobian mih ndim] }
  let(:num_array) { [1,2,3,4,5] }
  let(:num_array_clone) { num_array.clone }
  let(:num_array2) { [7,5,3,5,2] }

  describe '#my_each' do
    it "returns an enumerator if no block is given " do
      expect(array.my_each).to be_an(Enumerator)
    end
  end
end