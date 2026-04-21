// lib/services/seed/prompts/social_media_prompts.dart

class SocialMediaPrompts {
  static List<Map<String, String>> getPrompts(String subcategory) {
    switch (subcategory) {
      case 'Instagram Post':
        return [
          {
            'title': 'Pinterest Aesthetic Glow',
            'platform': 'Midjourney',
            'description': 'Convert your photo into a trendy Pinterest shot',
            'text': 'Transform this selfie into a "Pinterest Aesthetic" post. Soften the lighting to a warm morning glow. Add a minimalist, clean room background with plants and neutral tones. Enhance the image to look like a high-end lifestyle influencer’s feed. Maintain the exact face.',
          },
          {
            'title': 'Tezza Filter Vibe',
            'platform': 'Leonardo AI',
            'description': 'Apply a professional warm film filter',
            'text': 'Recreate this photo with a vintage film "Tezza" style filter. Warm orange and teal tones, slight grain, and soft highlights. Change the background to a trendy outdoor cafe. The person should look effortlessly stylish. Maintain the original facial features.',
          },
          {
            'title': 'Night City Neon Post',
            'platform': 'DALL-E 3',
            'description': 'Move your photo to a neon city street',
            'text': 'Take the person from this photo and place them on a busy street in Tokyo or Mumbai at night. Add vibrant neon signs in the background reflecting on their skin. High-fashion street style. Sharp focus and cinematic night lighting. Maintain the face.',
          },
          {
            'title': 'Luxury Travel Flat Lay',
            'platform': 'Midjourney',
            'description': 'Add luxury travel items to your photo',
            'text': 'Modify this photo to be a travel-themed flat lay. The person should be sitting on a luxury hotel bed with a passport, designer sunglasses, and a camera next to them. Aesthetic white sheets and soft natural light. Maintain the face identity.',
          },
          {
            'title': 'Old Money Aesthetic',
            'platform': 'Stable Diffusion XL',
            'description': 'A classy and expensive looking makeover',
            'text': 'Transform this photo into an "Old Money" aesthetic. Change the outfit to a premium white linen shirt or silk dress. Background is a classic library or a garden estate. Use soft, elegant lighting. Very expensive and clean look. Maintain face.',
          },
          {
            'title': 'Mirror Selfie Upgrade',
            'platform': 'Leonardo AI',
            'description': 'Turn a basic mirror selfie into a pro shot',
            'text': 'Recreate this mirror selfie as a professional fashion shoot. The "mirror" should be a high-end designer piece. Improve the lighting to highlight the outfit and face. Background is a modern minimalist loft. Maintain the person’s face and pose.',
          },
          {
            'title': 'Golden Hour Glow-up',
            'platform': 'Midjourney',
            'description': 'The perfect 5 PM sunset lighting',
            'text': 'Take the person from this photo and place them in a field during the perfect golden hour. The sunlight should be hitting their hair and face from the side, creating a beautiful warm glow. Soft focus background. Maintain face identity.',
          },
          {
            'title': 'Streetwear Magazine Shot',
            'platform': 'DALL-E 3',
            'description': 'You on a Hypebeast style post',
            'text': 'Modify this photo to look like a post for Hypebeast. Change the person’s outfit to trendy oversized streetwear. Background is an urban concrete wall with minimal graffiti. Bold colors and high-contrast professional lighting. Maintain face.',
          },
          {
            'title': 'Minimalist Studio Portrait',
            'platform': 'Leonardo AI',
            'description': 'Clean, professional, and trendy',
            'text': 'Convert this photo into a minimalist studio shot. Use a solid pastel-colored background. The person should look sharp and well-lit with professional studio lights. Clean skin texture and polished look. Maintain facial features.',
          },
          {
            'title': 'Boho Nature Post',
            'platform': 'Flux AI',
            'description': 'A relaxed and artistic outdoor vibe',
            'text': 'Transform this photo into a bohemian nature theme. Surround the person with pampas grass and soft sunlight. The outfit should be light and flowing. Aesthetic, earthy color palette. Maintain the person\'s identity.',
          },
        ];

      case 'YouTube Thumbnail':
        return [
          {
            'title': 'Shocked Reaction Face',
            'platform': 'Midjourney',
            'description': 'The classic high-CTR reaction thumbnail',
            'text': 'Transform the person in this photo to have an extremely "shocked" and "surprised" facial expression with wide eyes and open mouth. Enhance the colors to be very bright and saturated. Dark background with a glowing neon border around the person.',
          },
          {
            'title': 'Tech Reviewer Setup',
            'platform': 'Leonardo AI',
            'description': 'See yourself as a pro tech YouTuber',
            'text': 'Take the person from this photo and place them in a high-end tech studio. Background should have RGB neon lights, a professional microphone, and sound-proofing panels. The person should be holding a glowing futuristic smartphone. Maintain face.',
          },
          {
            'title': 'Money & Success Theme',
            'platform': 'DALL-E 3',
            'description': 'Business/Finance channel style',
            'text': 'Recreate this photo showing the person as a successful entrepreneur. Add a luxury sports car and a modern mansion in the background. Saturated colors and high contrast. The person should look confident. Maintain the original face.',
          },
          {
            'title': 'Travel Vlog Hook',
            'platform': 'Midjourney',
            'description': 'An epic travel channel thumbnail',
            'text': 'Modify this photo to show the person at the edge of a breathtaking cliff in Bali or Iceland. The landscape should be epic and vast. Add a "Before vs After" style split lighting effect. High-action travel vlog vibe. Maintain face identity.',
          },
          {
            'title': 'Fitness Transformation Reveal',
            'platform': 'Stable Diffusion XL',
            'description': 'The ultimate "Weight Loss" visual',
            'text': 'Create a side-by-side thumbnail. On the right, transform the person from this photo into a highly fit, muscular version of themselves in a gym. Bright, bold text saying "RESULT" in the middle. High-energy sports lighting. Maintain face.',
          },
          {
            'title': 'Gaming Streamer Glow',
            'platform': 'Leonardo AI',
            'description': 'Professional gaming setup background',
            'text': 'Take the person from this photo and place them in a dark gaming room. The only light should be the purple and blue glow from a PC monitor on their face. Add a gaming headset over their ears. "Live" icon in the corner. Maintain face.',
          },
          {
            'title': 'VS Style Comparison',
            'platform': 'Midjourney',
            'description': 'Two different looks in one frame',
            'text': 'Take the person from this photo and create a "Good vs Evil" or "Cheap vs Expensive" comparison. Left side is dark and moody, right side is bright and gold. Both sides feature the same face. High contrast thumbnail style.',
          },
          {
            'title': 'MrBeast Style saturated',
            'platform': 'DALL-E 3',
            'description': 'Ultra-bright and click-worthy colors',
            'text': 'Modify this photo to have "MrBeast" style high-saturation colors. Make the eyes slightly larger and brighter. Add a dramatic action-packed background like an explosion or a pile of gold. Very clean cutout effect. Maintain face identity.',
          },
          {
            'title': 'Educational Expert Look',
            'platform': 'Leonardo AI',
            'description': 'Dignified and smart thumbnail',
            'text': 'Recreate this person as an expert teacher or scientist. Change background to a whiteboard with complex math or a library. Add glasses to the person. Professional and trustworthy atmosphere. Clear, sharp thumbnail quality. Maintain face.',
          },
          {
            'title': 'Horror Story Mood',
            'platform': 'Flux AI',
            'description': 'Spooky thumbnail for story channels',
            'text': 'Transform this photo into a horror thumbnail. The person should have a terrified expression. Background is a dark, haunted abandoned house with a ghostly figure in the distance. Blue and cold color grading. Maintain recognizable face.',
          },
        ];

      case 'Reels Cover':
        return [
          {
            'title': 'Cinematic Walk Hook',
            'platform': 'Midjourney',
            'description': 'The perfect vertical cover for vlogs',
            'text': 'Transform this photo into a cinematic Reel cover. The person should be walking towards the camera in a stylish city street at night. Use a wide-angle lens effect and slow-motion motion blur in the background. Vertical 9:16. Maintain face.',
          },
          {
            'title': 'Travel "Wanderlust" Cover',
            'platform': 'Leonardo AI',
            'description': 'A breathtaking vertical landscape cover',
            'text': 'Take the person from this photo and place them on a mountain top looking at a sunrise. Vertical orientation. Add elegant, thin text saying "THE ESCAPE" in the center. Breathtaking scenery and soft lighting. Maintain original face features.',
          },
          {
            'title': 'Fashion Reel "Outfit of Day"',
            'platform': 'DALL-E 3',
            'description': 'High-fashion vertical portrait',
            'text': 'Recreate this photo as an OOTD (Outfit of the day) Reel cover. The person should be in a high-fashion pose in a luxury apartment. Add a text overlay "GET READY WITH ME". Bright, clean, magazine-quality lighting. Maintain face.',
          },
          {
            'title': 'Workout Motivation Cover',
            'platform': 'Midjourney',
            'description': 'Powerful vertical gym shot',
            'text': 'Modify this photo to show the person at the end of a workout, sweating and drinking water. Intense gym lighting with deep shadows. Vertical orientation. Add text "NO EXCUSES" in bold typography. Maintain face identity.',
          },
          {
            'title': 'Mini-Vlog Daily Aesthetic',
            'platform': 'Stable Diffusion XL',
            'description': 'A soft and cozy daily life cover',
            'text': 'Transform this photo into a "Day in my life" Reel cover. The setting should be an aesthetic kitchen or bedroom with soft morning light. Add a cozy, relatable vibe. Soft pastel colors. Maintain the person’s original face.',
          },
          {
            'title': 'Cooking Reel "Chef" Cover',
            'platform': 'Leonardo AI',
            'description': 'Show off your culinary skills',
            'text': 'Take the person from this photo and show them tossing food in a pan with a flame. Vertical orientation. Background is a high-end restaurant kitchen. Add text "SECRET RECIPE". High-action cooking photography. Maintain face.',
          },
          {
            'title': 'Transformation "Before/After"',
            'platform': 'Midjourney',
            'description': 'A vertical split for transitions',
            'text': 'Create a vertical split cover. Left side is the original person, right side is the person transformed into a model or hero. Both sides feature the same face. Perfect for "Transition" Reels. High contrast and clean line.',
          },
          {
            'title': 'Dance Reel "Pop" Style',
            'platform': 'DALL-E 3',
            'description': 'Colorful and energetic cover',
            'text': 'Modify this photo to show the person in a dynamic dance pose. Add colorful graffiti and neon lights in the background. High energy and vibrant. Vertical 9:16. Maintain the original facial features and identity.',
          },
          {
            'title': 'Luxury Lifestyle Hook',
            'platform': 'Leonardo AI',
            'description': 'Aspirational high-end cover',
            'text': 'Recreate this photo as a luxury lifestyle Reel cover. Person sitting in the back of a luxury car or a private jet. Add text "LIVING THE DREAM". Sophisticated lighting and premium textures. Maintain the face.',
          },
          {
            'title': 'ASMR/Aesthetic Minimal',
            'platform': 'Flux AI',
            'description': 'Very clean and quiet visual cover',
            'text': 'Convert this photo into a minimalist aesthetic cover. Focus on a single object like a cup of tea or a candle, with the person blurred in the background. Very soft and peaceful. Clear vertical layout. Maintain unrecognizable face.',
          },
        ];

      case 'Quote Posts':
        return [
          {
            'title': 'Minimalist Zen Quote',
            'platform': 'Midjourney',
            'description': 'Clean and peaceful text background',
            'text': 'Transform this photo into a minimalist quote background. Use a vast, calm desert or ocean scene with a lot of empty space. Add a placeholder for text in the center with a very thin, elegant serif font. Peaceful and high-end.',
          },
          {
            'title': 'Dark Mood Motivation',
            'platform': 'Leonardo AI',
            'description': 'Powerful and gritty for gym/business',
            'text': 'Recreate this photo as a dark, high-contrast motivational background. Use a close-up of a textured surface like stone or dark metal. Add dramatic shadows. Perfect for "Alpha" or "Grind" quotes. High resolution.',
          },
          {
            'title': 'Dreamy Sunset Quote',
            'platform': 'DALL-E 3',
            'description': 'Beautiful and romantic background',
            'text': 'Take the person from this photo and place them as a small silhouette against a giant, beautiful pink and orange sunset. The quote text should be in the clouds. Romantic and inspiring. Maintain the person’s profile shape.',
          },
          {
            'title': 'Old Paper Vintage Quote',
            'platform': 'Midjourney',
            'description': 'A nostalgic, handwritten look',
            'text': 'Transform this photo into a vintage, tattered piece of parchment paper. Add an aesthetic of dried flowers and an old ink pen nearby. Top-down view. Space for handwritten-style quotes. Nostalgic and artistic.',
          },
          {
            'title': 'Neon Cyberpunk Wisdom',
            'platform': 'Stable Diffusion XL',
            'description': 'Modern and edgy for tech/gaming',
            'text': 'Modify this photo into a neon-lit cyberpunk background. Use glowing blue and magenta lines. High-tech, futuristic aesthetic. Space for digital-style typography. Clean and sharp graphics.',
          },
          {
            'title': 'Morning Coffee Quote',
            'platform': 'Leonardo AI',
            'description': 'Cozy and relatable for stories',
            'text': 'Take this coffee cup photo and turn it into an aesthetic "Morning Motivation" background. Add a soft window light, a plant, and a cozy blanket texture. Soft pastel colors. Space for quote text on the table.',
          },
          {
            'title': 'Mountain Peak Success',
            'platform': 'Midjourney',
            'description': 'Inspirational and epic scale',
            'text': 'Recreate this photo showing a person standing at the top of a massive mountain looking at the horizon. Epic scale and grand perspective. Perfect for "Success" and "Vision" quotes. High-quality landscape photography.',
          },
          {
            'title': 'Luxury Gold Text Base',
            'platform': 'DALL-E 3',
            'description': 'Premium and rich for luxury niches',
            'text': 'Transform this photo into a luxury black and gold background. Use flowing silk textures and gold foil accents. Extremely sophisticated and high-end. Space for elegant golden typography in the center.',
          },
          {
            'title': 'Forest Path Journey',
            'platform': 'Leonardo AI',
            'description': 'Spiritual and calm for life quotes',
            'text': 'Modify this photo into a serene forest path with light filtering through the trees. The path represents "The Journey." Soft green and golden tones. Peaceful and reflective atmosphere. Space for quote text.',
          },
          {
            'title': 'City Skyline Hustle',
            'platform': 'Flux AI',
            'description': 'Modern business and ambition vibe',
            'text': 'Convert this photo into a high-end city skyline at night. Lights from buildings creating a bokeh effect. Perfect for "Business" or "Hustle" quotes. Modern urban aesthetic. Professional photography.',
          },
        ];

      case 'Story Templates':
        return [
          {
            'title': 'Daily Vlog "Polaroid"',
            'platform': 'Midjourney',
            'description': 'A cute retro story layout',
            'text': 'Transform this photo into a retro Polaroid story template. Place the photo inside a white polaroid frame with a handwritten "Today" at the bottom. Background is an aesthetic bedroom with fairy lights. Soft and nostalgic.',
          },
          {
            'title': 'Modern Collage Grid',
            'platform': 'Leonardo AI',
            'description': 'Multiple photos in one clean design',
            'text': 'Take the person from this photo and create a 3-photo vertical grid collage. Top photo is a close-up, middle is a lifestyle shot, bottom is a detail. Clean white borders. Modern and minimal story design.',
          },
          {
            'title': 'Question & Answer Box',
            'platform': 'DALL-E 3',
            'description': 'Interactive and fun for followers',
            'text': 'Recreate this photo as a Q&A story template. The person should be smiling on one side, with a stylized "Ask me anything" box on the other. Background is a bright, cheerful colorful gradient. Maintaining face.',
          },
          {
            'title': 'New Post Alert Glow',
            'platform': 'Midjourney',
            'description': 'Catchy way to promote your feed',
            'text': 'Modify this photo to be a "New Post" alert. Add a glowing frame around the person and a large "NEW POST" sticker in a stylish font. Background is blurred and aesthetic. High contrast and attention-grabbing.',
          },
          {
            'title': 'Music Playlist Vibe',
            'platform': 'Stable Diffusion XL',
            'description': 'Share your mood with a song',
            'text': 'Transform this photo into a Spotify-style music player story. Place the photo as the "Album Art". Add a play/pause button and a progress bar overlay. Background colors should match the photo colors. Aesthetic and trendy.',
          },
          {
            'title': 'Travel Itinerary Day 1',
            'platform': 'Leonardo AI',
            'description': 'Share your travel plans',
            'text': 'Take the person from this photo and place them in a travel story template. Add a checklist on the side with "Day 1" destinations. Background is a beautiful map or airport window. Adventure theme. Maintain face.',
          },
          {
            'title': 'Cozy "Get Ready" Vibe',
            'platform': 'Midjourney',
            'description': 'Morning routine aesthetic',
            'text': 'Recreate this photo as a "Get Ready with Me" story. Add a soft-focus mirror edge and a morning coffee cup. The lighting should be soft and fresh. Add a "Morning" text in elegant script. Maintain face.',
          },
          {
            'title': 'Product "Shop Now" Tag',
            'platform': 'DALL-E 3',
            'description': 'For business and brand owners',
            'text': 'Modify this photo to show the person holding a product. Add a stylized "Shop Now" button and a price tag animation frame. Background is a professional studio. Perfect for E-commerce stories. Maintain face.',
          },
          {
            'title': 'Night Out "Vibe" Post',
            'platform': 'Leonardo AI',
            'description': 'Dark and cool for parties',
            'text': 'Transform this photo into a night-out story. Add a slight motion blur and "flash" effect. Background is a blurred club or city lights. Add a "Current Vibe" text overlay. Cool and energetic. Maintain face.',
          },
          {
            'title': 'Fitness Goal "Checkmark"',
            'platform': 'Flux AI',
            'description': 'Track your workout progress',
            'text': 'Convert this photo into a fitness story template. Add a circular progress ring and a "Workout Complete" badge. The person should look fit and energetic. Gym background. Maintain facial features.',
          },
        ];

      case 'Meme Templates':
        return [
          {
            'title': 'The Confused Side-eye',
            'platform': 'Midjourney',
            'description': 'Convert your face into a funny reaction',
            'text': 'Transform the person in this photo into a "Confused and Suspicious" reaction meme. Slightly exaggerate the eye-roll and the frown. Background is a simple blurry office or room. Clear expression, perfect for adding text.',
          },
          {
            'title': 'Expectation vs Reality',
            'platform': 'Leonardo AI',
            'description': 'A classic two-frame comparison',
            'text': 'Create a two-frame meme template. Top frame: The person looking glamorous and professional. Bottom frame: The person looking exhausted and messy. Both frames must use the same face from the original photo. Funny contrast.',
          },
          {
            'title': 'The Desi Mom/Dad Meme',
            'platform': 'DALL-E 3',
            'description': 'Relatable Indian family humor',
            'text': 'Recreate this person as a stereotypical Indian parent. Add a pair of glasses on the nose and a "serious" lecturing expression. They should be holding a phone too far from their face. Hilarious and relatable. Maintain face.',
          },
          {
            'title': 'Mind Blown / Galaxy Brain',
            'platform': 'Midjourney',
            'description': 'Extreme realization reaction',
            'text': 'Modify this photo to show the person with a "Mind Blown" expression. Add glowing light and cosmic galaxies coming out of their head. Exaggerated expression of shock and awe. 3D surreal effect. Maintain face.',
          },
          {
            'title': 'The "Success" Kid Look',
            'platform': 'Stable Diffusion XL',
            'description': 'A small victory celebration',
            'text': 'Transform the person from this photo into a "Success" meme. Fist clenched, a determined and proud expression on the face. Background is a simple beach or park. The person should look like a winner. Maintain face.',
          },
          {
            'title': 'Distracted Boyfriend Swap',
            'platform': 'Leonardo AI',
            'description': 'Put yourself in an iconic meme',
            'text': 'Recreate the famous "Distracted Boyfriend" meme, but replace the main walking person with the person from this photo. The face and clothes should match the original photo while the pose matches the meme. Hilarious transformation.',
          },
          {
            'title': 'The Professional Clown',
            'platform': 'Midjourney',
            'description': 'For when you make a big mistake',
            'text': 'Take the person from this photo and add subtle clown makeup (nose and wig) overlaying their original face. They should be wearing a professional suit. Perfect for "me after making a bad choice" memes. Maintain face.',
          },
          {
            'title': 'Drake Hotline Bling Style',
            'platform': 'DALL-E 3',
            'description': 'The classic No/Yes meme',
            'text': 'Create a meme template with two panels. Panel 1: Person making a disgusted face and blocking with hand. Panel 2: Person making a happy, approving face and pointing. Both panels use the face from the photo. Funny and clear.',
          },
          {
            'title': 'Crying but Smiling',
            'platform': 'Leonardo AI',
            'description': 'Hiding the pain behind a smile',
            'text': 'Modify this photo to show the person with a huge, fake smile but with large, realistic tears in their eyes. The background is a "This is Fine" burning room. Deeply funny and relatable. Maintain face identity.',
          },
          {
            'title': 'Gigachad Transformation',
            'platform': 'Flux AI',
            'description': 'The ultimate debt and confidence',
            'text': 'Convert the man in this photo into a "Gigachad" version. Exaggerate the jawline and muscle structure while keeping the facial identity recognizable. Black and white high-contrast filter. The ultimate confidence meme.',
          },
        ];

      default:
        return [];
    }
  }
}
