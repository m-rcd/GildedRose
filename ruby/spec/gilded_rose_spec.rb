require './lib/gilded_rose'
# require './lib/gilded_rose1'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "degrades twice as fast if sell_in date has passed" do
      items = [Item.new("foo", -1, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    context 'Aged Brie' do
      it 'increases the older it gets' do
        items = [Item.new("Aged Brie", 3, 4)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(5)
      end

    end

    it "can't increase more than 50" do
      items = [Item.new("Aged Brie", 3, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(50)
    end

    it 'cannot decrease in quality if name is sulfuras' do
      items = [Item.new("Sulfuras, Hand of Ragnaros", -1, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(80)
    end

    context 'Backstage passes' do
      it 'increases the older it gets' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 16, 4)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(5)
      end

      it 'increases by 2 if sell_in < 11' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 4)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(6)
      end
    end
  end
end
