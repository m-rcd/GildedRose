class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.sell_in < 0 && item.name != 'Sulfuras, Hand of Ragnaros'
        item.quality -= 2
      end

      if item.name == 'Aged Brie'
        item.quality += 1 unless item.quality == 50
      end

      if item.name == 'Backstage passes to a TAFKAL80ETC concert'
        if item.sell_in < 11
          item.quality += 2
        else
        item.quality += 1
        end
      end
    end
  end
end





class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
