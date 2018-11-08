class GildedRose
  MAX_QUALITY = 50

  def update_quality(item)
    update_backstage_quality(item) if backstage_quality_less_than_max?(item)
    update_regular_item_quality(item) if regular_item_and_positive?(item)
    item.quality += 1 if brie_and_less_than_max?(item)
    update_conjured_quality(item) if conjured_item?(item)
  end

  def update_sell_in(item)
    item.sell_in -= 1 unless sulfuras?(item)
  end

  def update_regular_item_quality(item)
    item.sell_in.negative? ? item.quality -= 2 : item.quality -= 1
  end

  def update_backstage_quality(item)
    return item.quality = 0 if item.sell_in.negative?
    return item.quality += 3 if item.sell_in < 6

    return item.sell_in < 11 ?  item.quality += 2 : item.quality += 1
  end

  def update_conjured_quality(item)
    item.quality -= 2 if item.quality > 1
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
    true if !sulfuras?(item) && !backstage?(item) && !aged_brie?(item) && !conjured_item?(item)
  end

  def conjured_item?(item)
    item.name == 'Conjured Mana Cake'
  end

  def backstage_quality_less_than_max?(item)
    backstage?(item) && item.quality < MAX_QUALITY
  end

  def regular_item_and_positive?(item)
    regular_item(item) && item.quality.positive?
  end

  def brie_and_less_than_max?(item)
    aged_brie?(item) && item.quality < MAX_QUALITY
  end
end
