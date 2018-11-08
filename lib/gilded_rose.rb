class GildedRose
  def update_quality(item)
     if item.name ==  'Backstage passes to a TAFKAL80ETC concert' && quality_less_than_max?(item)
       if item.sell_in < 0
         item.quality = 0
       elsif item.sell_in < 6
         item.quality += 3
       elsif item.sell_in < 11
         item.quality += 2
       else
       item.quality += 1
       end
     end

   if regular_item(item)
     item.sell_in < 0 ? item.quality -= 2 : item.quality -= 1
   end

   item.quality += 1 if item.name == 'Aged Brie' && quality_less_than_max?(item)
 end

  def update_sell_in(item)
    item.sell_in -= 1 if item.name != "Sulfuras, Hand of Ragnaros"
  end

  private

  def quality_less_than_max?(item)
    item.quality < 50
  end

  def regular_item(item)
    true if item.name != 'Sulfuras, Hand of Ragnaros' && item.name !=  'Backstage passes to a TAFKAL80ETC concert' && item.name != 'Aged Brie'
  end
end
