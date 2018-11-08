class GildedRose
  MAX_quality = 50

  def update_quality(item)
    if backstage?(item) && item.quality < MAX_quality
      update_backstage_quality(item)
    end

    if regular_item(item) && item.quality > 0
      item.sell_in < 0 ? item.quality -= 2 : item.quality -= 1
    end

    item.quality += 1 if aged_brie?(item) && item.quality < MAX_quality
  end

  def update_sell_in(item)
    item.sell_in -= 1 if sulfuras?(item)
  end

  def update_backstage_quality(item)
    return item.quality = 0 if item.sell_in < 0
    return item.quality += 3 if item.sell_in < 6
    return item.sell_in < 11 ?  item.quality += 2 : item.quality += 1
  end

  private

  def backstage?(item)
    item.name == 'Backstage passes to a TAFKAL80ETC concert'
  end

  def aged_brie?(item)
    item.name == 'Aged Brie'
  end

  def sulfuras?(item)
    item.name == 'Sulfuras, Hand of Ragnaros'
  end

  def regular_item(item)
    true if !sulfuras?(item) && !backstage?(item) && !aged_brie?(item)
  end
end
