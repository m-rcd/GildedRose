require './lib/item'

describe Item do
  describe '#to_s' do
    subject(:item) { described_class.new('Foo', 3, 3) }

    it 'format item to string' do
      expect(item.to_s()).to eq('Foo, 3, 3')
    end
  end
end
