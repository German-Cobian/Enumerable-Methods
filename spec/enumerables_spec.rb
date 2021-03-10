require './enumerables.rb'

describe 'Enumerables' do
  let(:str_array) { %w[germain julius cobian mih ndim] }
  let(:num_array) { [1,2,3,4,5] }
  let(:num_array2) { [7,5,3,5,2] }
  let(:mixed_array) { ['dog', 5, 'song', 99, 'git', 54]}
  let(:num_array_clone) { num_array.clone }


  describe '#my_each' do

    it "works identically to ruby\'s #each method when a block is given" do
    expect(num_array.my_each { |elem| (elem * 5)}).to eq(num_array.each { |i| i.send('*', 5)})
    end

    it 'does not mutate the original array' do
      expect(num_array.my_each{|elt| elt + 1}).to eq(num_array_clone)
    end


    it "returns an enumerator if no block is given " do
      expect(num_array.my_each).to be_an(Enumerator)
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
    
    it 'does not mutate the original array'do
      expect(num_array.my_select {|element| element + 2} ).to eq(num_array_clone)
    end

    it 'returns an enumerator if no block is given' do
      expect(range.my_select).to be_an(Enumerator)
    end

  end
  
  describe '#my_all?' do
    let(:str_block) { proc { |str| str.is_a? String } }
    let(:int_block) { proc { |int| int.is_a? Integer }}

    it 'returns true if the block never evaluates to false' do
      expect(num_array.my_all?(&int_block)).to eq(num_array.all?(&int_block))
    end

    it 'returns false if the block never evaluates to true' do
      expect(num_array.my_all?(&str_block)).to eq(num_array.all?(&str_block))
    end

    it 'does not mutate the original array' do
      num_array.my_all? {|num| num + 3}
      expect(num_array).to eq(num_array_clone)
    end
    
    context 'when argument is a class' do
      it 'returns true if all the elements belong to the class'do
      expect(str_array.my_all?(String)).to be str_array.all?(String)
      end

      it 'returns false if not all elements belong to the class' do
        expect(mixed_array.my_all?(String)).to be mixed_array.all?(String)
      end
    end

    context "when no block or argument is given" do
      it 'returns true if all elements of the array evaluate to true' do
        expect(num_array.my_all?).to be num_array.all?
      end      

      it 'returns false if array contains nil' do
        num_array << nil
        expect(num_array.my_all?).to be num_array.all?
      end
    end
    
    context 'when a regex is passed as an argument'do
      it 'returns true if the elements contains the regex pattern' do
        expect(str_array.my_all?(/i/)).to eq(true)
      end
      it 'returns false if the elements do not contain the regex pattern' do
        expect(str_array.my_all?(/u/)).to eq(false)
      end
    end
  end

  describe '#my_any?' do
    let(:str_block) { proc { |str| str.is_a? String } }
    let(:int_block) { proc { |int| int.is_a? Integer }} 

    it 'returns true if the block evaluates to true at least once' do
      expect(mixed_array.my_any?(&int_block)).to eq(mixed_array.any?(&int_block))
    end

    it 'returns false if the block never evaluates to true' do
      expect(num_array.my_any?(&str_block)).to eq(num_array.any?(&str_block))
    end

    it 'does not mutate the original array' do
      num_array.my_any? {|num| num + 3}
      expect(num_array).to eq(num_array_clone)
    end

    context 'when argument is a class' do
      it 'returns true if at least one element belongs to the class'do
      expect(mixed_array.my_any?(String)).to be mixed_array.any?(String)
      end

      it 'returns false if none of the elements belong to the class' do
        expect(num_array.my_any?(String)).to be num_array.any?(String)
      end
    end

    context "when no block or argument is given" do
      it 'returns true if any of the elements of the array evaluate to true' do
        expect(num_array.my_any?).to be num_array.any?
      end      

      it 'returns false if none of the elements in the array evaluates to true' do
        nil_array = [nil, nil, false]
        expect(nil_array.my_any?).to be nil_array.any?
      end
    end

    context 'when a regex is passed as an argument'do
      it 'returns true if at least one of the elements contains the regex pattern' do
        expect(str_array.my_any?(/h/)).to eq(true)
      end
      it 'returns false if none of the elements contain the regex pattern' do
        expect(str_array.my_any?(/x/)).to eq(false)
      end
    end

  end

  describe '#my_none' do
    let(:str_block) { proc { |str| str.is_a? String } }
    let(:int_block) { proc { |int| int.is_a? Integer }} 

    it 'returns true if the block never evaluates to true' do
      expect(str_array.my_none?(&int_block)).to eq(str_array.none?(&int_block))
    end

    it 'returns false if the block evaluates to true at least once' do
      expect(mixed_array.my_none?(&str_block)).to eq(mixed_array.none?(&str_block))
    end

    it 'does not mutate the original array' do
      num_array.my_none? {|num| num + 3}
      expect(num_array).to eq(num_array_clone)
    end
  end

  context 'when argument is a class' do
    it 'returns true if none of the elements belongs to the class'do
    expect(num_array.my_none?(String)).to be num_array.none?(String)
    end

    it 'returns false if at least one of the elements belong to the class' do
      expect(mixed_array.my_none?(String)).to be mixed_array.none?(String)
    end
  end

  context "when no block or argument is given" do
    it 'returns true if none of the elements of the array evaluate to true' do
      nil_array = [nil, nil, false]
      expect(nil_array.my_none?).to be nil_array.none?
    end      

    it 'returns false if at least one of the elements in the array evaluates to true' do
      expect(num_array.my_none?).to be num_array.none?
    end
  end
end