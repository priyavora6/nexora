// lib/services/seed/prompts/fashion_lifestyle_prompts.dart

class FashionLifestylePrompts {
  static List<Map<String, String>> getPrompts(String subcategory) {
    switch (subcategory) {
      case 'High Fashion':
        return [
          {
            'title': 'High Fashion Editorial',
            'platform': 'Midjourney',
            'description': 'Avant-garde fashion photography',
            'text': 'Avant-garde high fashion editorial of Indian female model in structured architectural metallic gown, futuristic silhouette, dramatic makeup, industrial warehouse setting, high contrast lighting, Vogue magazine aesthetic, 8K --ar 4:5 --v 6',
          },
          {
            'title': 'Luxury Watch Shot',
            'platform': 'DALL-E 3',
            'description': 'Luxury watch commercial shot',
            'text': 'Close-up editorial shot of a luxury watch on a well-dressed Indian man wrist, tailored suit sleeve visible, expensive leather car interior background, soft morning sunlight, premium lifestyle aesthetic, sharp focus on watch dial',
          },
          {
            'title': 'Designer Handbag',
            'platform': 'Leonardo AI',
            'description': 'High-end accessory photography',
            'text': 'High-end designer leather handbag carried by elegant Indian woman in stylish street wear, Parisian street background, soft focus city lights, luxury fashion photography, detailed leather texture, professional lighting',
          },
          {
            'title': 'Fashion Week Catwalk',
            'platform': 'Stable Diffusion XL',
            'description': 'Runway fashion photography',
            'text': 'Indian male model walking on fashion week runway, wearing trendy oversized trench coat and wide trousers, intense spotlight, blurred audience in background, dynamic movement captured, high-end fashion photography',
          },
          {
            'title': 'Jewelry Campaign',
            'platform': 'Midjourney',
            'description': 'Fine jewelry advertisement look',
            'text': 'Close-up portrait of Indian woman wearing heavy diamond and emerald necklace, matching earrings, elegant evening gown, dark velvet background, dramatic lighting highlighting gem sparkles, luxury jewelry campaign --ar 4:5 --v 6',
          },
          {
            'title': 'Paris Runway Walk',
            'platform': 'Leonardo AI',
            'description': 'Classic high fashion catwalk',
            'text': 'Indian female model walking a Paris runway, wearing an elegant Dior-style gown, flashing cameras in the background, sharp highlights and deep shadows, iconic fashion week moment',
          },
          {
            'title': 'Gothic Glamour Look',
            'platform': 'DALL-E 3',
            'description': 'Dark and mysterious high fashion',
            'text': 'Indian model in a dark gothic couture outfit, heavy lace and black velvet, dramatic dark makeup, abandoned cathedral background, moody cinematic lighting, high-end fashion art',
          },
          {
            'title': 'Cyber-Couture Future',
            'platform': 'Midjourney',
            'description': 'Futuristic designer clothing',
            'text': 'Futuristic high fashion dress made of glowing optical fibers and translucent plastic, worn by an Indian model, neon-lit lab background, 8k resolution, futuristic vogue style',
          },
          {
            'title': 'Minimalist Luxury Style',
            'platform': 'Leonardo AI',
            'description': 'Clean and expensive designer look',
            'text': 'Indian male model in a beige cashmere overcoat and white trousers, minimalist modern architecture background, soft natural light, clean skin, architectural digest fashion style',
          },
          {
            'title': 'Monochrome Elegance',
            'platform': 'Flux AI',
            'description': 'Striking black and white fashion',
            'text': 'High-contrast black and white fashion portrait of an Indian woman, wearing a dramatic wide-brimmed hat and structural gown, sharp shadows, elegant and timeless editorial style',
          },
        ];

      case 'Street Style':
        return [
          {
            'title': 'Mumbai Streetwear',
            'platform': 'Midjourney',
            'description': 'Urban street fashion shot',
            'text': 'Cool young Indian man in trendy streetwear, oversized graphic tee, cargo pants, expensive sneakers, colorful graffiti wall in Mumbai background, urban street photography, natural overcast light, hip hop vibe --ar 4:5 --v 6',
          },
          {
            'title': 'Chic Cafe Look',
            'platform': 'DALL-E 3',
            'description': 'Casual stylish lifestyle photo',
            'text': 'Stylish Indian woman in chic casual outfit, floral dress with denim jacket, sitting at aesthetic outdoor cafe, holding iced latte, blurred cafe background, sunny afternoon light, Pinterest aesthetic, lifestyle photography',
          },
          {
            'title': 'Urban Techwear',
            'platform': 'Leonardo AI',
            'description': 'Modern urban tech style',
            'text': 'Futuristic urban techwear on Indian model, black tactical vest over hoodie, many straps and pockets, neon-lit rainy Tokyo street background, cinematic lighting, edgy street style, sharp focus',
          },
          {
            'title': 'Vintage Retro Vibe',
            'platform': 'Stable Diffusion XL',
            'description': '1990s retro fashion look',
            'text': 'Retro 90s street style portrait, Indian person in vintage baggy denim and colorful windbreaker, grainy film photography aesthetic, old school urban playground background, nostalgic cool vibe',
          },
          {
            'title': 'Casual Sunday Walk',
            'platform': 'Midjourney',
            'description': 'Relaxed lifestyle photography',
            'text': 'Young Indian couple in relaxed casual wear walking through a green park, holding hands, genuine laughter, soft morning sunlight through trees, natural candid photography, lifestyle aesthetic --ar 4:5 --v 6',
          },
          {
            'title': 'Tokyo Harajuku Style',
            'platform': 'Leonardo AI',
            'description': 'Colorful Japanese-inspired streetwear',
            'text': 'Indian model in extremely colorful and layered Harajuku style streetwear, walking in Tokyo, neon signs, vibrant saturated colors, playful and edgy urban fashion',
          },
          {
            'title': 'Skater Boy/Girl Aesthetic',
            'platform': 'Midjourney',
            'description': 'Youthful skating lifestyle',
            'text': 'Indian teenager sitting on a skateboard, wearing oversized hoodie and beanies, sunset at an urban skatepark, lens flare, film grain, cool youthful lifestyle photography',
          },
          {
            'title': 'Rainy London Street',
            'platform': 'Stable Diffusion XL',
            'description': 'Moody urban street lifestyle',
            'text': 'Indian man in a trench coat holding an umbrella on a rainy London street, red buses blurred in background, wet pavement reflections, moody cinematic street photography',
          },
          {
            'title': 'Graffiti Wall Portrait',
            'platform': 'Leonardo AI',
            'description': 'Edgy urban portrait',
            'text': 'Edgy portrait of an Indian woman leaning against a wall covered in vibrant graffiti art, wearing a leather jacket, harsh sunlight, high-contrast urban fashion',
          },
          {
            'title': '90s Hip Hop Style',
            'platform': 'Flux AI',
            'description': 'Classic old-school urban look',
            'text': 'Indian male model in 90s hip hop fashion, baggy tracksuits, gold chains, boombox in background, low angle fish-eye lens shot, vintage MTV aesthetic',
          },
        ];

      case 'Indian Ethnic':
        return [
          {
            'title': 'The Chikankari Classic',
            'platform': 'Midjourney',
            'description': 'Elegant Indian ethnic wear',
            'text': 'Beautiful Indian woman in white Chikankari kurta, delicate embroidery, silver jhumkas, sitting in a traditional haveli courtyard, soft morning sunlight, elegant and timeless, cultural fashion photography --ar 4:5 --v 6',
          },
          {
            'title': 'Rajasthani Royal Style',
            'platform': 'DALL-E 3',
            'description': 'Traditional royal Rajasthani look',
            'text': 'Indian woman in royal Rajasthani Poshak, heavy gota patti work, traditional jewelry, standing in front of ornate palace gate, vibrant colors, cinematic lighting, regal and majestic, cultural heritage photography',
          },
          {
            'title': 'The South Indian Grace',
            'platform': 'Leonardo AI',
            'description': 'Traditional South Indian saree',
            'text': 'Elegant South Indian woman in Kanjeevaram silk saree, temple jewelry, jasmine flowers in hair, inside a traditional temple hallway, soft lamp lighting, cultural grace and beauty, professional ethnic photography',
          },
          {
            'title': 'Pathani Suit Swagger',
            'platform': 'Stable Diffusion XL',
            'description': 'Stylish male ethnic wear',
            'text': 'Handsome Indian man in dark Pathani suit, confident pose, rugged look with beard, traditional haveli background, dramatic lighting, masculine ethnic fashion photography, high quality',
          },
          {
            'title': 'Heavy Bridal Lehenga',
            'platform': 'Midjourney',
            'description': 'Opulent Indian bridal fashion',
            'text': 'Stunning Indian bride in heavy red bridal lehenga, intricate gold work, full bridal jewelry, dramatic makeup, royal palace background, warm cinematic lighting, opulent bridal fashion photography --ar 4:5 --v 6',
          },
          {
            'title': 'The Grand Saree Try-on',
            'platform': 'Midjourney',
            'description': 'Vibrant silk saree showcase',
            'text': 'Indian model draping a heavy Banarasi silk saree, vibrant magenta and gold, mirror reflection showing the back, bright boutique lighting, luxurious ethnic fashion',
          },
          {
            'title': 'Royal Sherwani Makeover',
            'platform': 'Leonardo AI',
            'description': 'Groom-style ethnic wear',
            'text': 'Indian man in a royal cream sherwani with emerald buttons, standing in a marble palace corridor, soft evening light, noble and dignified ethnic fashion photography',
          },
          {
            'title': 'Indo-Western Fusion',
            'platform': 'DALL-E 3',
            'description': 'Modern twist on traditional wear',
            'text': 'Indian woman in a fusion outfit, ethnic crop top with modern trousers and a long cape, urban modern background, trendy and innovative Indian fashion',
          },
          {
            'title': 'Leheriya Festival Vibe',
            'platform': 'Leonardo AI',
            'description': 'Colorful Rajasthani festival look',
            'text': 'Indian girl twirling in a colorful Leheriya dupatta, bright sunny village festival background, motion blur on the fabric, joyful and vibrant cultural photography',
          },
          {
            'title': 'Designer Nehru Jacket',
            'platform': 'Flux AI',
            'description': 'Smart casual ethnic look',
            'text': 'Indian male model in a floral printed Nehru jacket over a white kurta, minimalist studio background, soft shadows, clean and sophisticated ethnic style',
          },
        ];

      case 'Fitness Gym':
        return [
          {
            'title': 'Intense Gym Workout',
            'platform': 'Midjourney',
            'description': 'Powerful fitness action shot',
            'text': 'Muscular Indian man performing heavy deadlift in gritty underground gym, sweat dripping, intense focus, dramatic low-key lighting, chalk dust in air, powerful fitness photography, cinematic look --ar 4:5 --v 6',
          },
          {
            'title': 'Yoga Morning Serenity',
            'platform': 'DALL-E 3',
            'description': 'Peaceful yoga lifestyle photo',
            'text': 'Peaceful Indian woman performing advanced yoga pose on rooftop at sunrise, city skyline in background, soft morning light, calm serene expression, healthy lifestyle photography, zen atmosphere',
          },
          {
            'title': 'Crossfit High Energy',
            'platform': 'Leonardo AI',
            'description': 'Dynamic fitness photography',
            'text': 'Fit Indian woman performing dynamic Crossfit movement with battle ropes, high energy, motion blur on ropes, modern gym background, bright energetic lighting, athletic lifestyle photography',
          },
          {
            'title': 'Outdoor Running Track',
            'platform': 'Stable Diffusion XL',
            'description': 'Active outdoor fitness shot',
            'text': 'Athletic Indian man running on modern red track, morning fog, fit physique, dynamic running pose, side view, natural lighting, healthy active life photography, sharp focus',
          },
          {
            'title': 'Home Workout Vibe',
            'platform': 'Midjourney',
            'description': 'Casual home fitness lifestyle',
            'text': 'Fit young Indian woman exercising in a modern aesthetic living room, yoga mat, dumbbells, sunlight through window, relaxed healthy home environment, lifestyle fitness photography --ar 4:5 --v 6',
          },
          {
            'title': 'Future Fit Version',
            'platform': 'Midjourney',
            'description': 'Cyberpunk inspired athlete',
            'text': 'Indian male athlete in futuristic neon-glowing gym wear, high-tech training room with holographic displays, intense energy, dramatic blue and violet lighting',
          },
          {
            'title': 'Yoga in the Himalayas',
            'platform': 'DALL-E 3',
            'description': 'Epic scale mountain yoga',
            'text': 'Indian woman meditating in a yoga pose on a mountain edge in the Himalayas, snow peaks in background, thin atmosphere, crystal clear bright sun, epic peace',
          },
          {
            'title': 'The Crossfit Challenge',
            'platform': 'Midjourney',
            'description': 'Gritty functional fitness',
            'text': 'Indian woman flipping a massive tractor tire in an outdoor gritty gym, veins showing, sweat, intense determination, harsh afternoon sun, high-action fitness shot',
          },
          {
            'title': 'Aesthetic Home Gym',
            'platform': 'Stable Diffusion XL',
            'description': 'Luxury home fitness setup',
            'text': 'Indian man using a high-end rowing machine in a minimalist luxury home gym with wooden walls and large plants, soft morning light, peaceful and healthy lifestyle',
          },
          {
            'title': 'The Marathon Finisher',
            'platform': 'Leonardo AI',
            'description': 'Emotional sports achievement',
            'text': 'Indian runner crossing a marathon finish line, cheering crowd blurred, water being thrown, emotional happy face, high speed sports photography',
          },
        ];

      case 'Beauty Makeup':
        return [
          {
            'title': 'Glamorous Party Makeup',
            'platform': 'Midjourney',
            'description': 'Close-up beauty photography',
            'text': 'Extreme close-up of Indian woman with glamorous party makeup, bold red lips, shimmering eyeshadow, long lashes, flawless skin, dramatic studio lighting, beauty magazine quality, sharp detail --ar 4:5 --v 6',
          },
          {
            'title': 'Natural Glow Look',
            'platform': 'DALL-E 3',
            'description': 'Minimalist "no-makeup" makeup',
            'text': 'Beauty portrait of Indian woman with natural "no-makeup" look, dewy skin, soft pink lips, natural sunlight through window, clean and fresh aesthetic, skincare advertisement style, professional photography',
          },
          {
            'title': 'Bridal Beauty Detail',
            'platform': 'Leonardo AI',
            'description': 'Indian bridal makeup close-up',
            'text': 'Close-up of Indian bride makeup, heavy kohl eyes, intricate nose ring, gold forehead jewelry, traditional bridal look, warm soft lighting, detailed texture, cultural beauty photography',
          },
          {
            'title': 'Creative Editorial Makeup',
            'platform': 'Stable Diffusion XL',
            'description': 'Artistic fashion makeup art',
            'text': 'Artistic beauty shot of Indian model with creative editorial makeup, colorful geometric shapes around eyes, avant-garde style, high fashion photography, bright pop colors, sharp focus',
          },
          {
            'title': 'Classic Indian Bindi',
            'platform': 'Midjourney',
            'description': 'Cultural beauty portrait',
            'text': 'Elegant portrait of Indian woman focusing on traditional bindi and eyes, subtle traditional makeup, soft lighting, cultural grace, professional beauty photography, close-up --ar 4:5 --v 6',
          },
          {
            'title': 'Digital Glamour Makeover',
            'platform': 'Midjourney',
            'description': 'Hyper-real studio beauty',
            'text': 'Hyper-realistic beauty shot of an Indian woman, focus on glowing highlighter and gold eye shadow, flawless airbrushed skin, professional studio lighting, 8k resolution',
          },
          {
            'title': 'Artistic Eye Makeup',
            'platform': 'Leonardo AI',
            'description': 'Focus on colorful eye art',
            'text': 'Extreme macro shot of an eye with rainbow-colored artistic makeup, long intricate lashes, every skin pore visible, vibrant and creative beauty art',
          },
          {
            'title': 'The Bridal Glow',
            'platform': 'DALL-E 3',
            'description': 'Radiant wedding makeup',
            'text': 'Indian bride face with glowing golden-hour makeup, warm highlights, soft blush, intricate head jewelry, radiant and happy expression, professional wedding photography',
          },
          {
            'title': 'Halloween Spooky Makeup',
            'platform': 'Leonardo AI',
            'description': 'Creative dark makeup art',
            'text': 'Indian model with high-quality artistic skull face paint, glamorous yet spooky, dark moody lighting, cinematic textures, creative makeup photography',
          },
          {
            'title': 'Cyber-Beauty Neon',
            'platform': 'Flux AI',
            'description': 'Futuristic glow-in-the-dark makeup',
            'text': 'Indian woman with UV-reactive neon makeup glowing under blacklight, geometric patterns on face, cyber-punk aesthetic, vibrant electric blue and pink colors',
          },
        ];

      case 'Accessories':
        return [
          {
            'title': 'Traditional Gold Jhumkas',
            'platform': 'Midjourney',
            'description': 'Close-up jewelry detail',
            'text': 'Close-up of traditional Indian gold jhumka earrings worn by a model, intricate gold work, soft skin texture, warm luxury lighting, detailed macro photography, jewelry advertisement quality --ar 4:5 --v 6',
          },
          {
            'title': 'Stylish Sunglasses Urban',
            'platform': 'DALL-E 3',
            'description': 'Trendy accessory lifestyle',
            'text': 'Stylish young Indian man wearing trendy designer sunglasses, reflection of city street in lenses, cool urban outfit, city sidewalk background, natural daylight, fashion accessory photography',
          },
          {
            'title': 'Handcrafted Leather Belt',
            'platform': 'Leonardo AI',
            'description': 'Detailed product photography',
            'text': 'Close-up of handcrafted leather belt on denim jeans, Indian man wearing, detailed leather grain and buckle, rustic wood background, soft side lighting, professional product photography',
          },
          {
            'title': 'Modern Minimalist Watch',
            'platform': 'Stable Diffusion XL',
            'description': 'Clean watch product shot',
            'text': 'Minimalist watch on Indian woman wrist, clean white blouse, simple elegant design, soft focus office background, professional commercial photography, clean aesthetic',
          },
          {
            'title': 'Silk Scarf Fashion',
            'platform': 'Midjourney',
            'description': 'Soft accessory photography',
            'text': 'Elegant Indian woman wearing a colorful silk scarf, wind blowing scarf softly, outdoor garden background, soft morning light, graceful fashion accessory photography --ar 4:5 --v 6',
          },
          {
            'title': 'Luxury Watch Add-on',
            'platform': 'Midjourney',
            'description': 'Premium metal watch detail',
            'text': 'Close-up of a high-end silver and gold automatic watch on an Indian man’s wrist, luxury car steering wheel in background, sharp metal reflections, premium commercial photography',
          },
          {
            'title': 'Diamond Jewelry Suite',
            'platform': 'Leonardo AI',
            'description': 'Complete necklace and earrings set',
            'text': 'Indian woman in a black velvet dress wearing a full set of diamond necklace, earrings and maang-tikka, dramatic lighting making the diamonds sparkle, luxury campaign style',
          },
          {
            'title': 'Cool Aviator Style',
            'platform': 'DALL-E 3',
            'description': 'Classic masculine sunglasses',
            'text': 'Indian man in a leather jacket wearing classic gold aviator sunglasses, desert background, rugged and stylish, high-contrast fashion photography',
          },
          {
            'title': 'Traditional Gold Bangles',
            'platform': 'DALL-E 3',
            'description': 'Hand jewelry focus',
            'text': 'Close-up of an Indian woman’s hands adorned with dozens of intricate gold bangles, henna (mehndi) patterns visible, soft warm lighting, cultural accessory photography',
          },
          {
            'title': 'Ethnic Jutti & Footwear',
            'platform': 'Flux AI',
            'description': 'Traditional embroidered shoes',
            'text': 'Close-up of colorful embroidered Punjabi Juttis on a traditional rug, intricate thread work and beads, soft side lighting, cultural product photography',
          },
        ];

      default:
        return [];
    }
  }
}
