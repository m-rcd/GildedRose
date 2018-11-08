require './lib/gilded_rose'

describe GildedRose do
  subject(:gildedRose) { described_class.new }
  class MockItem
    attr_accessor :name, :sell_in, :quality
    def initialize(name, sell_in, quality)
      @name = name
      @sell_in = sell_in
      @quality = quality
    end
  end

  describe "#update_quality" do
    context 'Regular item' do
      it 'cannot go below 0' do
        item = MockItem.new("foo", 3, 0)
        gildedRose.update_quality(item)
        expect(item.quality).to eq(0)
      end
    end

    context 'Aged Brie' do
      it 'increases the older it gets' do
        item = MockItem.new("Aged Brie", 3, 4)
        gildedRose.update_quality(item)
        expect(item.quality).to eq(5)
      end

      it "can't increase more than 50" do
        item = MockItem.new("Aged Brie", 3, 50)
        gildedRose.update_quality(item)
        expect(item.quality).to eq(50)
      end
    end

    context 'Sulfuras' do
      it 'cannot decrease in quality if name is sulfuras' do
        item = MockItem.new("Sulfuras, Hand of Ragnaros", -1, 80)
        gildedRose.update_quality(item)
        expect(item.quality).to eq(80)
      end
    end

    context 'Backstage passes' do
      it "can't increase more than 50" do
        item = MockItem.new("Backstage passes to a TAFKAL80ETC concert", 3, 50)
        gildedRose.update_quality(item)
        expect(item.quality).to eq(50)
      end
    end

    context 'Conjured item' do
      it 'can update quality' do
        item = MockItem.new("Conjured Mana Cake", 0, 30)
        gildedRose.update_quality(item)
        expect(item.quality).to eq(28)
      end
    end
  end

  describe '#update_backstage_quality' do
    it 'increases the older it gets' do
      item = MockItem.new("Backstage passes to a TAFKAL80ETC concert", 16, 4)
      gildedRose.update_backstage_quality(item)
      expect(item.quality).to eq(5)
    end

    it 'sets item quality to 0 if sellin < 0' do
      item = MockItem.new("Backstage passes to a TAFKAL80ETC concert", -1, 4)
      gildedRose.update_backstage_quality(item)
      expect(item.quality).to eq(0)
    end

    it 'increases by 3 if sell_in < 6' do
      item = MockItem.new("Backstage passes to a TAFKAL80ETC concert", 4, 4)
      gildedRose.update_backstage_quality(item)
      expect(item.quality).to eq(7)
    end

    it 'increases by 2 if sell_in < 11' do
      item = MockItem.new("Backstage passes to a TAFKAL80ETC concert", 9, 4)
      gildedRose.update_backstage_quality(item)
      expect(item.quality).to eq(6)
    end
  end

  describe '#update_regular_item_quality' do
    it "degrades twice as fast if sell_in date has passed" do
      item = MockItem.new("foo", -1, 2)
      gildedRose.update_regular_item_quality(item)
      expect(item.quality).to eq 0
    end

    it 'degrades by 1 as it gets older' do
      item = MockItem.new("foo", 3, 2)
      gildedRose.update_regular_item_quality(item)
      expect(item.quality).to eq(1)
    end
  end

  describe '#update_sell_in' do
    it 'decreases sell_in' do
      item = MockItem.new('foo', 2, 2)
      gildedRose.update_sell_in(item)
      expect(item.sell_in).to eq(1)
    end

    it 'does not alter if name is Sulfuras' do
      item = MockItem.new("Sulfuras, Hand of Ragnaros", 0, 80)
      gildedRose.update_sell_in(item)
      expect(item.sell_in).to eq(0)
    end
  end

  describe '#update_conjured_quality' do
    it 'decreases quality by 2 everyday' do
      item = MockItem.new("Conjured Mana Cake", 0, 30)
      gildedRose.update_conjured_quality(item)
      expect(item.quality).to eq(28)
    end
  end
end
