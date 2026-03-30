// lib/services/seed/prompts/product_ecommerce_prompts.dart

class ProductEcommercePrompts {
  static List<Map<String, String>> getPrompts(String subcategory) {
    switch (subcategory) {
      case 'Electronics Gadgets':
        return [
          {'title': 'Floating Smartphone', 'platform': 'Midjourney', 'description': 'Premium phone product shot', 'text': 'Premium smartphone floating in mid-air, dramatic dark background with subtle blue glow, screen showing vibrant display, reflective surface below, Apple-style product photography, ultra clean minimal, 8K commercial quality'},
          {'title': 'Wireless Earbuds Case', 'platform': 'DALL-E 3', 'description': 'TWS earbuds product photo', 'text': 'Premium wireless earbuds in charging case, matte white finish, one earbud floating out, clean white background, soft studio lighting, AirPods style product photography'},
          {'title': 'Laptop Lifestyle Shot', 'platform': 'Leonardo AI', 'description': 'Laptop in workspace setting', 'text': 'Sleek modern laptop on minimalist desk, coffee cup beside, morning sunlight through window, clean workspace, lifestyle product photography, tech brand commercial quality'},
          {'title': 'Smartwatch on Wrist', 'platform': 'Stable Diffusion XL', 'description': 'Smartwatch lifestyle photo', 'text': 'Premium smartwatch on athletic wrist, fitness tracking screen visible, gym background blurred, active lifestyle product photography, health technology commercial'},
          {'title': 'Gaming Console Setup', 'platform': 'Gemini AI', 'description': 'Gaming system product shot', 'text': 'Next-gen gaming console with controller, LED ambient lighting, entertainment center setup, dramatic dark background with RGB glow, gaming product photography'},
          {'title': 'Bluetooth Speaker', 'platform': 'Adobe Firefly', 'description': 'Portable speaker product', 'text': 'Portable Bluetooth speaker outdoor scene, poolside or beach setting, waterproof design visible, vibrant colors, lifestyle product photography, summer vibes'},
          {'title': 'Camera DSLR Product', 'platform': 'Midjourney', 'description': 'Professional camera shot', 'text': 'Professional DSLR camera with lens, dramatic studio lighting, black reflective surface, technical precision visible, photographer equipment product photography'},
          {'title': 'Tablet with Stylus', 'platform': 'Flux AI', 'description': 'Digital tablet product', 'text': 'Premium digital tablet with stylus pen, artist drawing on screen, creative workspace, clean modern desk, digital art tool product photography'},
          {'title': 'Power Bank Portable', 'platform': 'DALL-E 3', 'description': 'Portable charger product', 'text': 'Sleek power bank charging smartphone, travel setting, backpack nearby, LED indicator lights glowing, portable charging product photography, travel essential'},
          {'title': 'Smart Home Hub', 'platform': 'Leonardo AI', 'description': 'Smart home device product', 'text': 'Smart home hub device on modern table, ambient lighting responding to voice, futuristic home automation, clean living room setting, smart technology product photography'},
        ];

      case 'Fashion Apparel':
        return [
          {'title': 'Saree Flat Lay', 'platform': 'Midjourney', 'description': 'Indian saree product display', 'text': 'Beautiful Indian silk saree flat lay photography, rich red and gold fabric elegantly folded, matching blouse piece, jewelry accessories around, white marble surface, overhead product shot, fashion e-commerce quality'},
          {'title': 'Mens Suit Mannequin', 'platform': 'DALL-E 3', 'description': 'Formal suit on mannequin', 'text': 'Premium navy blue mens suit on mannequin, perfect tailoring visible, silk tie and pocket square, professional studio lighting, dark gradient background, menswear product photography'},
          {'title': 'Sneaker Hero Shot', 'platform': 'Leonardo AI', 'description': 'Athletic shoe product photo', 'text': 'Dynamic sneaker product shot, shoe floating at angle, splash of color dust around, dramatic lighting, clean background, athletic footwear commercial photography'},
          {'title': 'Designer Handbag', 'platform': 'Stable Diffusion XL', 'description': 'Luxury bag product shot', 'text': 'Luxury designer handbag on pedestal, premium leather texture visible, gold hardware gleaming, elegant studio lighting, fashion accessories product photography'},
          {'title': 'Kurta Set Display', 'platform': 'Gemini AI', 'description': 'Indian ethnic menswear', 'text': 'Elegant Indian kurta pajama set displayed on hanger, intricate embroidery detail visible, matching dupatta, festival wear product photography, ethnic fashion e-commerce'},
          {'title': 'Lehenga Bridal Set', 'platform': 'Adobe Firefly', 'description': 'Bridal outfit product display', 'text': 'Stunning bridal lehenga choli set, red and gold heavy embroidery, dupatta draped elegantly, bridal jewelry accessories, luxury Indian bridal fashion product photography'},
          {'title': 'Kids Clothing Set', 'platform': 'Midjourney', 'description': 'Children outfit product', 'text': 'Cute kids clothing set flat lay, colorful printed t-shirt and shorts, small shoes and accessories, playful arrangement, bright cheerful styling, children fashion product photography'},
          {'title': 'Denim Jacket Style', 'platform': 'Flux AI', 'description': 'Casual jacket product', 'text': 'Classic denim jacket product photography, styled on wooden hanger, distressed wash detail, casual styling accessories nearby, rustic background, streetwear product shot'},
          {'title': 'Sports Jersey Display', 'platform': 'DALL-E 3', 'description': 'Athletic jersey product', 'text': 'Cricket team jersey product display, number and name visible, moisture-wicking fabric detail, team colors vibrant, sports merchandise product photography'},
          {'title': 'Sunglasses Product', 'platform': 'Leonardo AI', 'description': 'Premium eyewear shot', 'text': 'Designer sunglasses on reflective surface, premium build quality visible, dramatic side lighting creating shadows, fashion accessories product photography, luxury eyewear commercial'},
        ];

      case 'Beauty Cosmetics':
        return [
          {'title': 'Lipstick Collection', 'platform': 'Midjourney', 'description': 'Multiple lipstick shades', 'text': 'Luxury lipstick collection arranged artistically, multiple rich shades from nude to bold red, golden tubes standing upright, soft pink marble background, beauty product photography, cosmetics commercial'},
          {'title': 'Skincare Routine Flat Lay', 'platform': 'DALL-E 3', 'description': 'Complete skincare products', 'text': 'Complete skincare routine flat lay, cleanser toner serum moisturizer SPF, minimalist white packaging, green botanical elements, clean aesthetic, beauty brand product photography'},
          {'title': 'Foundation Shade Range', 'platform': 'Leonardo AI', 'description': 'Multiple foundation shades', 'text': 'Foundation shade range swatches on skin, diverse Indian skin tones represented, product bottles in background, inclusive beauty, cosmetics shade matching product photography'},
          {'title': 'Eyeshadow Palette', 'platform': 'Stable Diffusion XL', 'description': 'Colorful eyeshadow palette', 'text': 'Stunning eyeshadow palette open showing 12 colors, shimmer and matte finishes, makeup brush dusted with pigment, beauty product detail photography, cosmetics commercial'},
          {'title': 'Perfume Bottle Luxury', 'platform': 'Gemini AI', 'description': 'Premium fragrance bottle', 'text': 'Luxury perfume bottle, elegant glass design, golden cap, light refracting through liquid, silk fabric draped around, premium fragrance product photography'},
          {'title': 'Hair Oil Indian Brand', 'platform': 'Adobe Firefly', 'description': 'Traditional hair oil product', 'text': 'Premium Indian hair oil bottle, coconut and amla ingredients visible, traditional meets modern packaging, healthy hair imagery, Ayurvedic beauty product photography'},
          {'title': 'Nail Polish Colors', 'platform': 'Midjourney', 'description': 'Nail paint collection', 'text': 'Vibrant nail polish bottles lined up in rainbow order, glossy liquid dripping from brushes, colorful reflections, beauty product arrangement photography'},
          {'title': 'Face Mask Sachet', 'platform': 'Flux AI', 'description': 'Sheet mask product photo', 'text': 'Sheet face mask product photography, woman applying mask, glowing hydrated skin, spa atmosphere, minimal clean packaging, K-beauty inspired skincare product shot'},
          {'title': 'Makeup Brush Set', 'platform': 'DALL-E 3', 'description': 'Professional brush collection', 'text': 'Professional makeup brush set in leather case, various brush shapes and sizes, rose gold handles, professional artistry tools, beauty equipment product photography'},
          {'title': 'Kajal Eyeliner Indian', 'platform': 'Leonardo AI', 'description': 'Traditional Indian kajal', 'text': 'Indian kajal eyeliner product shot, dramatic smokey eye result shown, traditional beauty product, bold defined eyes, desi beauty product photography'},
        ];

      case 'Jewelry Watches':
        return [
          {'title': 'Diamond Necklace Set', 'platform': 'Midjourney', 'description': 'Luxury diamond jewelry set', 'text': 'Stunning diamond necklace and earring set on black velvet display, sparkling brilliance, intricate craftsmanship, luxury jewelry photography, dark dramatic lighting, commercial quality'},
          {'title': 'Gold Bangles Stack', 'platform': 'DALL-E 3', 'description': 'Traditional gold bangles', 'text': 'Stack of traditional Indian gold bangles, intricate filigree work, warm golden glow, silk fabric background, bridal jewelry product photography, Indian goldsmith craftsmanship'},
          {'title': 'Luxury Watch Close-up', 'platform': 'Leonardo AI', 'description': 'Premium wristwatch detail', 'text': 'Ultra close-up of luxury mechanical watch, intricate dial details visible, sapphire crystal reflection, premium steel bracelet, horology product photography, watch commercial'},
          {'title': 'Silver Anklets Pair', 'platform': 'Stable Diffusion XL', 'description': 'Traditional silver payal', 'text': 'Beautiful Indian silver anklets payal, delicate bell charms, traditional design, displayed on silk, wedding jewelry product photography, cultural accessory'},
          {'title': 'Engagement Ring Set', 'platform': 'Gemini AI', 'description': 'Diamond ring product shot', 'text': 'Diamond engagement ring and wedding band set, platinum setting, brilliant cut stone, romantic rose petal around, jewelry product photography, bridal jewelry commercial'},
          {'title': 'Pearl Necklace Classic', 'platform': 'Adobe Firefly', 'description': 'Classic pearl strand', 'text': 'Classic pearl necklace strand, lustrous white pearls, elegant clasp detail, draped on dark velvet, timeless elegance, luxury pearl jewelry product photography'},
          {'title': 'Kundan Bridal Set', 'platform': 'Midjourney', 'description': 'Indian kundan jewelry', 'text': 'Magnificent Indian kundan bridal jewelry set, necklace earrings maang tikka, colored stones and gold, royal Rajasthani craftsmanship, bridal jewelry product photography'},
          {'title': 'Smart Watch Sport', 'platform': 'Flux AI', 'description': 'Digital sports watch', 'text': 'Modern sports smartwatch, rugged outdoor design, digital display showing fitness data, silicone strap, active lifestyle product photography, tech wearable commercial'},
          {'title': 'Mangalsutra Modern', 'platform': 'DALL-E 3', 'description': 'Contemporary mangalsutra', 'text': 'Modern Indian mangalsutra design, contemporary minimal pendant, black beads chain, diamond accent, traditional meets modern, bridal jewelry product photography'},
          {'title': 'Mens Bracelet Leather', 'platform': 'Leonardo AI', 'description': 'Mens fashion bracelet', 'text': 'Premium mens leather bracelet with metal clasp, rugged masculine accessory, styled on wooden surface, fashion accessory product photography, mens jewelry commercial'},
        ];

      case 'Home Furniture':
        return [
          {'title': 'Modern Sofa Set', 'platform': 'Midjourney', 'description': 'Contemporary living room sofa', 'text': 'Modern L-shaped sofa set in contemporary living room, premium fabric upholstery, cushions arranged perfectly, coffee table with decor, natural lighting, furniture product photography'},
          {'title': 'Wooden Dining Table', 'platform': 'DALL-E 3', 'description': 'Solid wood dining set', 'text': 'Solid sheesham wood dining table with six chairs, beautiful wood grain visible, table set for dinner, warm dining room ambiance, Indian home furniture product photography'},
          {'title': 'Bed with Mattress', 'platform': 'Leonardo AI', 'description': 'Premium bed setup', 'text': 'King size bed with premium mattress, crisp white bedding, multiple pillows arrangement, modern bedroom setting, comfortable inviting, bedroom furniture product photography'},
          {'title': 'Bookshelf Wall Unit', 'platform': 'Stable Diffusion XL', 'description': 'Modern bookcase display', 'text': 'Modern wall-mounted bookshelf unit, books and decorative items arranged, wooden and metal design, study room setting, storage furniture product photography'},
          {'title': 'Office Desk Setup', 'platform': 'Gemini AI', 'description': 'Work from home desk', 'text': 'Ergonomic home office desk setup, standing desk with monitor, organized cable management, plants and accessories, productive workspace furniture product photography'},
          {'title': 'Traditional Jhoola Swing', 'platform': 'Adobe Firefly', 'description': 'Indian indoor swing', 'text': 'Beautiful Indian traditional wooden jhoola swing, carved details, chain hung from ceiling, cushioned seat, traditional home decor, Indian furniture product photography'},
          {'title': 'Wardrobe Closet', 'platform': 'Midjourney', 'description': 'Modern wardrobe unit', 'text': 'Spacious modern wardrobe with sliding doors, organized interior visible, clothes and accessories arranged, mirror panel, bedroom storage furniture product photography'},
          {'title': 'Pooja Room Cabinet', 'platform': 'Flux AI', 'description': 'Traditional prayer cabinet', 'text': 'Beautiful pooja room wooden cabinet, intricate carved doors, brass bell and diya inside, spiritual home furniture, Indian traditional pooja mandir product photography'},
          {'title': 'Garden Outdoor Furniture', 'platform': 'DALL-E 3', 'description': 'Patio furniture set', 'text': 'Stylish outdoor garden furniture set, weather resistant rattan, comfortable cushions, patio setting with plants, evening ambiance, outdoor furniture product photography'},
          {'title': 'Kids Study Table', 'platform': 'Leonardo AI', 'description': 'Children study desk', 'text': 'Colorful kids study table and chair set, storage shelves, organized stationery, cheerful room setting, child-friendly design, children furniture product photography'},
        ];

      case 'Packaging Design':
        return [
          {'title': 'Premium Gift Box', 'platform': 'Midjourney', 'description': 'Luxury gift packaging', 'text': 'Premium luxury gift box packaging design, magnetic closure, embossed gold logo on matte black, ribbon detail, tissue paper inside, luxury unboxing experience, packaging design photography'},
          {'title': 'Tea Brand Packaging', 'platform': 'DALL-E 3', 'description': 'Indian chai brand box', 'text': 'Artisan Indian tea brand packaging, kraft paper box with illustration, traditional chai ingredients depicted, warm earthy colors, heritage brand design, food packaging photography'},
          {'title': 'Cosmetic Product Box', 'platform': 'Leonardo AI', 'description': 'Beauty product packaging', 'text': 'Elegant cosmetics product packaging, minimalist white box with rose gold accents, product visible through window cutout, premium beauty brand, packaging design photography'},
          {'title': 'Food Delivery Box', 'platform': 'Stable Diffusion XL', 'description': 'Restaurant takeaway packaging', 'text': 'Branded restaurant delivery packaging, eco-friendly kraft material, fun illustrations, branded stickers, organized compartments for food items, food delivery packaging design'},
          {'title': 'E-commerce Mailer Box', 'platform': 'Gemini AI', 'description': 'Online shopping package', 'text': 'Branded e-commerce mailer box, custom printed exterior, branded tissue paper inside, thank you card, unboxing experience design, online shopping packaging photography'},
          {'title': 'Spice Box Collection', 'platform': 'Adobe Firefly', 'description': 'Indian masala packaging', 'text': 'Colorful Indian spice collection packaging, individual labeled jars in wooden box, traditional spice names, vibrant ingredient colors visible, gourmet food gift packaging'},
          {'title': 'Sustainable Packaging', 'platform': 'Midjourney', 'description': 'Eco friendly green packaging', 'text': 'Sustainable eco-friendly product packaging, recyclable materials, green branding, minimal waste design, plant-based packaging, environmental responsibility, sustainable packaging photography'},
          {'title': 'Perfume Gift Set', 'platform': 'Flux AI', 'description': 'Fragrance set packaging', 'text': 'Luxury perfume gift set packaging, three mini bottles in velvet-lined box, premium ribbon closure, brand emblem, gifting ready luxury packaging design photography'},
          {'title': 'Chocolate Box Premium', 'platform': 'DALL-E 3', 'description': 'Artisan chocolate packaging', 'text': 'Premium artisan chocolate box, assorted handcrafted chocolates visible, gold foil accents, elegant dark packaging, confectionery gift box design photography'},
          {'title': 'Subscription Box Design', 'platform': 'Leonardo AI', 'description': 'Monthly subscription box', 'text': 'Exciting subscription box unboxing, curated products inside branded box, surprise element, colorful branded packaging, subscription commerce design photography'},
        ];

      default:
        return [];
    }
  }
}
