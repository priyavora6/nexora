// lib/services/seed/prompts/portrait_headshots_prompts.dart

class PortraitHeadshotsPrompts {
  static List<Map<String, dynamic>> getPrompts(String subcategory) {
    switch (subcategory) {
      case 'LinkedIn Professional':
        return [
          {
            'title': 'Corporate CEO Headshot',
            'platform': 'Midjourney',
            'description': 'Professional executive LinkedIn photo',
            'text': 'Professional headshot of young Indian businessman in navy blue suit, confident smile, modern glass office background with city view, soft natural lighting, shallow depth of field, corporate magazine quality, 8K --ar 1:1 --v 6',
          },
          {
            'title': 'Friendly Business Woman',
            'platform': 'DALL-E 3',
            'description': 'Approachable female professional headshot',
            'text': 'Professional headshot of Indian businesswoman in her 30s, maroon blazer over white blouse, warm genuine smile, subtle makeup, neutral gray background, professional studio lighting, LinkedIn ready',
          },
          {
            'title': 'Tech Startup Founder',
            'platform': 'Leonardo AI',
            'description': 'Modern tech entrepreneur look',
            'text': 'Young Indian tech entrepreneur headshot, casual smart with dark sweater, stylish glasses, modern office with plants background, natural daylight, confident approachable expression, startup founder vibe',
          },
          {
            'title': 'Finance Executive',
            'platform': 'Stable Diffusion XL',
            'description': 'Banking professional portrait',
            'text': 'Indian finance executive portrait, charcoal three-piece suit, crisp white shirt, corporate building lobby background, trustworthy confident expression, investment banker style, professional photography',
          },
          {
            'title': 'Creative Director',
            'platform': 'Midjourney',
            'description': 'Artistic creative industry headshot',
            'text': 'Indian creative director headshot, stylish black turtleneck, artistic jewelry, design studio background with mood boards, confident creative pose, editorial photography --ar 4:5 --v 6',
          },
          {
            'title': 'Healthcare Doctor',
            'platform': 'DALL-E 3',
            'description': 'Medical professional headshot',
            'text': 'Professional portrait of Indian doctor, white lab coat, stethoscope visible, warm caring smile, clean hospital background, trustworthy medical professional, high quality photography',
          },
          {
            'title': 'Lawyer Attorney',
            'platform': 'Leonardo AI',
            'description': 'Legal professional portrait',
            'text': 'Indian lawyer professional headshot, formal black suit, dignified expression, law office with legal books background, authoritative yet approachable, professional legal photography',
          },
          {
            'title': 'Real Estate Agent',
            'platform': 'Gemini AI',
            'description': 'Friendly realtor headshot',
            'text': 'Indian real estate agent headshot, smart business casual, warm welcoming smile, modern property background, trustworthy friendly appearance, business card ready',
          },
          {
            'title': 'Marketing Manager',
            'platform': 'Adobe Firefly',
            'description': 'Dynamic marketing professional',
            'text': 'Indian marketing manager portrait, trendy business casual, energetic confident smile, creative agency background, dynamic personality, professional photography',
          },
          {
            'title': 'Professor Academic',
            'platform': 'Flux AI',
            'description': 'University professor headshot',
            'text': 'Indian university professor headshot, smart casual blazer, intellectual glasses, warm scholarly smile, university library background, knowledgeable approachable, academic profile ready',
          },
        ];

      case 'Dating Profile':
        return [
          {
            'title': 'Coffee Date Casual',
            'platform': 'Midjourney',
            'description': 'Attractive casual dating photo',
            'text': 'Attractive young Indian man at outdoor cafe, casual smart shirt, genuine warm smile, holding coffee cup, golden hour sunlight, bokeh cafe background, approachable confident vibe, 8K --ar 4:5 --v 6',
          },
          {
            'title': 'Adventure Traveler',
            'platform': 'DALL-E 3',
            'description': 'Adventurous travel dating photo',
            'text': 'Beautiful young Indian woman hiking, casual outdoor wear, backpack visible, genuine happy laugh, scenic mountain background, adventurous spirit, natural photography',
          },
          {
            'title': 'Beach Sunset Portrait',
            'platform': 'Leonardo AI',
            'description': 'Romantic beach dating photo',
            'text': 'Handsome Indian man at beach during sunset, casual linen shirt, relaxed confident pose, ocean waves background, golden hour lighting, romantic vacation vibes',
          },
          {
            'title': 'Bookshop Intellectual',
            'platform': 'Stable Diffusion XL',
            'description': 'Smart bookish dating profile',
            'text': 'Attractive Indian woman in cozy bookshop, holding book, stylish glasses, warm cardigan, bookshelves background, intelligent curious expression, intellectual dating match',
          },
          {
            'title': 'Dog Lover Portrait',
            'platform': 'Midjourney',
            'description': 'Pet lover dating photo',
            'text': 'Attractive young Indian man with cute golden retriever, park setting, genuine loving smile, casual clothing, warm sunlight, dog lover personality, heartwarming --ar 4:5 --v 6',
          },
          {
            'title': 'Foodie Restaurant',
            'platform': 'DALL-E 3',
            'description': 'Food enthusiast dating photo',
            'text': 'Charming Indian woman at trendy restaurant, stylish casual outfit, enjoying food, genuine happy expression, aesthetic restaurant interior, foodie personality',
          },
          {
            'title': 'Fitness Active',
            'platform': 'Leonardo AI',
            'description': 'Athletic dating profile photo',
            'text': 'Fit attractive Indian man after workout, athletic wear, healthy glow, confident smile, outdoor running track background, active healthy lifestyle',
          },
          {
            'title': 'Music Festival Fun',
            'platform': 'Gemini AI',
            'description': 'Fun music lover dating photo',
            'text': 'Beautiful Indian woman at music festival, bohemian outfit, dancing joyfully, colorful festival background, carefree happy expression, fun loving personality',
          },
          {
            'title': 'Rooftop City Views',
            'platform': 'Adobe Firefly',
            'description': 'Urban sophisticated dating photo',
            'text': 'Stylish Indian man on rooftop bar, smart casual outfit, city skyline background at dusk, sophisticated confident pose, urban lifestyle',
          },
          {
            'title': 'Art Gallery Cultured',
            'platform': 'Flux AI',
            'description': 'Cultured art lover dating photo',
            'text': 'Elegant Indian woman at art gallery, sophisticated outfit, admiring artwork, cultured intellectual appearance, museum background, classy dating profile',
          },
        ];

      case 'Corporate Business':
        return [
          {
            'title': 'CEO Power Portrait',
            'platform': 'Midjourney',
            'description': 'Commanding CEO corporate photo',
            'text': 'Powerful corporate portrait of Indian CEO, tailored charcoal suit, commanding presence, corner office with city view, executive leadership aura, Fortune 500 quality --ar 4:5 --v 6',
          },
          {
            'title': 'HR Manager Friendly',
            'platform': 'DALL-E 3',
            'description': 'Approachable HR professional',
            'text': 'Warm friendly corporate headshot of Indian HR manager, professional approachable smile, business casual, modern office background, welcoming trustworthy appearance',
          },
          {
            'title': 'Sales Executive Dynamic',
            'platform': 'Leonardo AI',
            'description': 'Energetic sales professional',
            'text': 'Dynamic corporate portrait of Indian sales executive, confident engaging smile, professional suit, energetic personality, modern sales office background',
          },
          {
            'title': 'IT Director Technical',
            'platform': 'Stable Diffusion XL',
            'description': 'Tech leadership portrait',
            'text': 'Professional headshot of Indian IT director, smart casual tech attire, confident knowledgeable expression, server room or tech office background, digital leader',
          },
          {
            'title': 'CFO Financial Expert',
            'platform': 'Gemini AI',
            'description': 'Senior finance executive portrait',
            'text': 'Distinguished corporate portrait of Indian CFO, impeccable formal suit, wise experienced expression, executive boardroom background, financial leadership presence',
          },
          {
            'title': 'COO Operations Leader',
            'platform': 'Midjourney',
            'description': 'Operations executive portrait',
            'text': 'Professional corporate headshot of Indian COO, efficient capable appearance, formal business attire, operational excellence vibe, corporate headquarters background --ar 1:1 --v 6',
          },
          {
            'title': 'Marketing Director Creative',
            'platform': 'Adobe Firefly',
            'description': 'Creative marketing leader',
            'text': 'Stylish corporate portrait of Indian marketing director, creative professional attire, innovative energetic expression, modern agency office background, brand builder',
          },
          {
            'title': 'Legal Counsel Authoritative',
            'platform': 'DALL-E 3',
            'description': 'Corporate legal professional',
            'text': 'Authoritative corporate portrait of Indian general counsel, formal legal attire, dignified serious expression, law office background, trustworthy legal expert',
          },
          {
            'title': 'Startup Founder Modern',
            'platform': 'Leonardo AI',
            'description': 'Young startup founder portrait',
            'text': 'Modern corporate portrait of young Indian startup founder, smart casual tech attire, visionary ambitious expression, innovative workspace background, entrepreneur vibe',
          },
          {
            'title': 'Board Member Distinguished',
            'platform': 'Flux AI',
            'description': 'Senior board member portrait',
            'text': 'Distinguished portrait of Indian board member, elegant formal attire, wise experienced expression, prestigious boardroom, governance leadership presence',
          },
        ];

      case 'Creative Artistic':
        return [
          {
            'title': 'Dramatic Shadow Portrait',
            'platform': 'Midjourney',
            'description': 'High contrast artistic portrait',
            'text': 'Dramatic artistic portrait of Indian person, half face illuminated half in shadow, high contrast black and white, intense eyes, fine art photography, gallery worthy --ar 3:4 --v 6',
          },
          {
            'title': 'Golden Hour Glow',
            'platform': 'DALL-E 3',
            'description': 'Ethereal golden light portrait',
            'text': 'Ethereal portrait of Indian woman bathed in golden hour sunlight, soft warm glow on face, flowing hair catching light, dreamy bokeh background, magical atmosphere',
          },
          {
            'title': 'Rain Window Reflection',
            'platform': 'Leonardo AI',
            'description': 'Moody rainy window portrait',
            'text': 'Moody artistic portrait through rain-streaked window, Indian person looking contemplatively, water droplets on glass, soft diffused light, melancholic beautiful atmosphere',
          },
          {
            'title': 'Double Exposure Art',
            'platform': 'Stable Diffusion XL',
            'description': 'Creative double exposure effect',
            'text': 'Artistic double exposure portrait, Indian woman face merged with blooming flowers, silhouette filled with nature, creative surreal effect, fine art composition',
          },
          {
            'title': 'Neon Cyberpunk Portrait',
            'platform': 'Midjourney',
            'description': 'Futuristic neon lit portrait',
            'text': 'Cyberpunk style portrait of young Indian person, neon pink and blue lighting on face, futuristic urban background, intense gaze, sci-fi aesthetic, blade runner inspired --ar 4:5 --v 6',
          },
          {
            'title': 'Smoke and Mystery',
            'platform': 'DALL-E 3',
            'description': 'Mysterious smoky atmosphere portrait',
            'text': 'Mysterious portrait with swirling smoke effects, Indian model emerging from darkness, dramatic theatrical lighting, enigmatic expression, dark moody atmosphere',
          },
          {
            'title': 'Vintage Film Grain',
            'platform': 'Leonardo AI',
            'description': 'Retro film photography style',
            'text': 'Vintage style portrait with authentic film grain, Indian person in classic pose, muted warm colors, nostalgic 1970s aesthetic, analog photography look, timeless',
          },
          {
            'title': 'Mirror Reflection Art',
            'platform': 'Gemini AI',
            'description': 'Creative mirror reflection portrait',
            'text': 'Artistic portrait using mirror reflections, multiple angles of Indian model face, creative composition, surreal artistic effect, conceptual photography',
          },
          {
            'title': 'Underwater Dream',
            'platform': 'Adobe Firefly',
            'description': 'Ethereal underwater style portrait',
            'text': 'Dreamy underwater inspired portrait, Indian woman with flowing fabric and hair, blue aquatic lighting, bubbles and light rays, ethereal mermaid vibes, surreal',
          },
          {
            'title': 'Prism Light Rainbow',
            'platform': 'Flux AI',
            'description': 'Rainbow prism light on face',
            'text': 'Artistic portrait with rainbow prism light across face, Indian model, colorful light refraction patterns on skin, dark background, creative lighting technique',
          },
        ];

      case 'Actor Model Portfolio':
        return [
          {
            'title': 'Dramatic Film Actor',
            'platform': 'Midjourney',
            'description': 'Intense movie actor headshot',
            'text': 'Cinematic actor headshot of Indian male actor, intense dramatic expression, professional studio lighting, black background, Bollywood film star quality, casting director ready --ar 4:5 --v 6',
          },
          {
            'title': 'Fashion Model Editorial',
            'platform': 'DALL-E 3',
            'description': 'High fashion model portrait',
            'text': 'High fashion editorial portrait of Indian female model, striking bone structure, dramatic makeup, haute couture styling, fashion magazine cover quality, Vogue aesthetic',
          },
          {
            'title': 'Commercial Model Friendly',
            'platform': 'Leonardo AI',
            'description': 'Approachable commercial model',
            'text': 'Commercial model headshot of Indian model, warm approachable smile, natural makeup, clean simple styling, versatile look for advertisements, relatable friendly',
          },
          {
            'title': 'Theatre Actor Expressive',
            'platform': 'Stable Diffusion XL',
            'description': 'Theatrical performer portrait',
            'text': 'Expressive theatre actor headshot, Indian performer, dynamic facial expression, dramatic theatrical lighting, stage presence captured, Broadway audition ready',
          },
          {
            'title': 'Runway Model Fierce',
            'platform': 'Gemini AI',
            'description': 'Catwalk model intense look',
            'text': 'Fierce runway model portrait of Indian model, smoldering intense gaze, high fashion styling, editorial lighting, designer campaign worthy, fashion week aesthetic',
          },
          {
            'title': 'TV Anchor Professional',
            'platform': 'Midjourney',
            'description': 'News anchor headshot',
            'text': 'Professional TV anchor headshot of Indian broadcaster, polished professional appearance, trustworthy confident expression, broadcast studio setting, news channel quality --ar 4:5 --v 6',
          },
          {
            'title': 'Fitness Model Athletic',
            'platform': 'Adobe Firefly',
            'description': 'Sports fitness model',
            'text': 'Athletic fitness model portrait of Indian model, toned physique visible, sportswear styling, dynamic confident pose, health and fitness campaign ready',
          },
          {
            'title': 'Character Actor Range',
            'platform': 'DALL-E 3',
            'description': 'Versatile character actor',
            'text': 'Character actor headshot of Indian performer, interesting unique features, expressive versatile face, ability to transform evident, indie film casting ready',
          },
          {
            'title': 'Voice Over Artist',
            'platform': 'Leonardo AI',
            'description': 'Voice actor professional photo',
            'text': 'Professional headshot of Indian voice over artist, warm engaging expression, approachable friendly appearance, studio microphone subtly visible, dubbing ready',
          },
          {
            'title': 'Dance Performer Graceful',
            'platform': 'Flux AI',
            'description': 'Professional dancer portrait',
            'text': 'Graceful dancer portrait of Indian classical dancer, elegant poised expression, hint of dance costume, artistic cultural aesthetic, dance company portfolio ready',
          },
        ];

      case 'Student Graduate':
        return [
          {
            'title': 'Graduation Cap Toss',
            'platform': 'Midjourney',
            'description': 'Celebrating graduation moment',
            'text': 'Joyful graduation celebration of Indian student, throwing cap in air, bright smile, university campus background, gown flowing, achievement celebration photography --ar 4:5 --v 6',
          },
          {
            'title': 'Formal Graduation Portrait',
            'platform': 'DALL-E 3',
            'description': 'Traditional graduation photo',
            'text': 'Formal graduation portrait of Indian graduate, black gown and cap, holding diploma, proud accomplished expression, university building background, traditional photography',
          },
          {
            'title': 'Medical Graduate Doctor',
            'platform': 'Leonardo AI',
            'description': 'New doctor graduation',
            'text': 'Proud medical graduation portrait of Indian medical graduate, white coat ceremony, stethoscope and diploma, accomplished expression, medical college background',
          },
          {
            'title': 'Engineering Graduate',
            'platform': 'Stable Diffusion XL',
            'description': 'Engineering degree celebration',
            'text': 'Happy engineering graduate portrait of Indian student, graduation regalia, technical college background, bright future expression, B.Tech graduation celebration',
          },
          {
            'title': 'Law School Graduate',
            'platform': 'Gemini AI',
            'description': 'Law degree graduation',
            'text': 'Distinguished law school graduation portrait of Indian graduate, formal legal academic regalia, law school building background, future lawyer confidence',
          },
          {
            'title': 'MBA Graduate Success',
            'platform': 'Midjourney',
            'description': 'Business school graduation',
            'text': 'Successful MBA graduation portrait of Indian graduate, business formal with gown, management institute background, future leader confidence --ar 4:5 --v 6',
          },
          {
            'title': 'PhD Scholar Achievement',
            'platform': 'Adobe Firefly',
            'description': 'Doctoral degree celebration',
            'text': 'Prestigious PhD graduation portrait of Indian doctoral scholar, academic regalia with doctoral hood, thesis achievement pride, university library background',
          },
          {
            'title': 'High School Graduate',
            'platform': 'DALL-E 3',
            'description': '12th class graduation',
            'text': 'Excited high school graduation portrait of Indian teenager, school graduation ceremony, proud parents nearby, first major achievement, 12th board success',
          },
          {
            'title': 'Study Abroad Graduate',
            'platform': 'Leonardo AI',
            'description': 'International university graduation',
            'text': 'International graduation portrait of Indian student abroad, foreign university graduation, multicultural celebration, global education achievement',
          },
          {
            'title': 'Arts Graduate Creative',
            'platform': 'Flux AI',
            'description': 'Fine arts graduation',
            'text': 'Creative arts graduation portrait of Indian graduate, artistic personality showing, fine arts college background, creative graduate celebration, unique expression',
          },
        ];

      default:
        return [];
    }
  }
}
