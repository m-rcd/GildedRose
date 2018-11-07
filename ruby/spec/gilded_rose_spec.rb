require './lib/gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      item = Item.new("foo", 0, 0)
      GildedRose.new.update_quality(item)
      expect(item.name).to eq "foo"
    end

    it "degrades twice as fast if sell_in date has passed" do
      item = Item.new("foo", -1, 2)
      GildedRose.new.update_quality(item)
      expect(item.quality).to eq 0
    end

    it 'degrades by 1 if it is not sulfuras or backstage passes or aged brie' do
      item = Item.new("foo", 3, 2)
      GildedRose.new.update_quality(item)
      expect(item.quality).to eq(1)
    end

    context 'Aged Brie' do
      it 'increases the older it gets' do
        item = Item.new("Aged Brie", 3, 4)
        GildedRose.new.update_quality(item)
        expect(item.quality).to eq(5)
      end
    end

    it "can't increase more than 50" do
      item = Item.new("Aged Brie", 3, 50)
      GildedRose.new.update_quality(item)
      expect(item.quality).to eq(50)
    end

    it 'cannot decrease in quality if name is sulfuras' do
      item = Item.new("Sulfuras, Hand of Ragnaros", -1, 80)
      GildedRose.new.update_quality(item)
      expect(item.quality).to eq(80)
    end

    context 'Backstage passes' do
      it 'increases the older it gets' do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", 16, 4)
        GildedRose.new.update_quality(item)
        expect(item.quality).to eq(5)
      end

      it 'increases by 2 if sell_in < 11' do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 4)
        GildedRose.new.update_quality(item)
        expect(item.quality).to eq(6)
      end

      it 'increases by 3 if sell_in < 6' do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 4)
        GildedRose.new.update_quality(item)
        expect(item.quality).to eq(7)
      end

      it 'goes down to 0 if sellin < 0' do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 4)
        GildedRose.new.update_quality(item)
        expect(item.quality).to eq(0)
      end

      it "can't increase more than 50" do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", 3, 50)
        GildedRose.new.update_quality(item)
        expect(item.quality).to eq(50)
      end
    end
  end

  describe '#update_sell_in' do
    it 'decreases sell_in' do
      item = Item.new('foo', 2, 2)
      GildedRose.new.update_sell_in(item)
      expect(item.sell_in).to eq(1)
    end

    it 'does not alter if name is Sulfuras' do
      item = Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
      GildedRose.new.update_sell_in(item)
      expect(item.sell_in).to eq(0)
    end
  end
end
