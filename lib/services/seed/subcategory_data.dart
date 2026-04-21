// lib/services/seed/subcategory_data.dart

class SubcategoryData {
  static List<Map<String, String>> getSubcategories(String category) {
    switch (category) {
    // ═══════════════════════════════════════════════════════════════
    // 1. PORTRAIT & HEADSHOTS
    // ═══════════════════════════════════════════════════════════════
      case 'Portrait & Headshots':
        return [
          {'name': 'LinkedIn Professional', 'description': 'Corporate headshots for LinkedIn profiles'},
          {'name': 'Dating Profile', 'description': 'Attractive photos for dating apps'},
          {'name': 'Corporate Business', 'description': 'Formal business headshots'},
          {'name': 'Creative Artistic', 'description': 'Artistic and creative portrait styles'},
          {'name': 'Actor Model Portfolio', 'description': 'Portfolio shots for actors and models'},
          {'name': 'Student Graduate', 'description': 'Graduation and student portraits'},
        ];

    // ═══════════════════════════════════════════════════════════════
    // 2. COUPLE & ROMANCE
    // ═══════════════════════════════════════════════════════════════
      case 'Couple & Romance':
        return [
          {'name': 'Valentine Special', 'description': 'Romantic Valentine day themed photos'},
          {'name': 'Engagement Proposal', 'description': 'Proposal and ring ceremony moments'},
          {'name': 'Couple Photoshoot', 'description': 'Professional couple photography'},
          {'name': 'Pre-Wedding', 'description': 'Pre-wedding shoot concepts'},
          {'name': 'Anniversary', 'description': 'Anniversary celebration photos'},
          {'name': 'Romantic Scenes', 'description': 'Beach sunset rain romantic moments'},
        ];

    // ═══════════════════════════════════════════════════════════════
    // 3. WEDDING & MARRIAGE
    // ═══════════════════════════════════════════════════════════════
      case 'Wedding & Marriage':
        return [
          {'name': 'Bridal Portraits', 'description': 'Beautiful bride photography'},
          {'name': 'Groom Portraits', 'description': 'Handsome groom photography'},
          {'name': 'Haldi Ceremony', 'description': 'Traditional haldi function'},
          {'name': 'Mehndi Function', 'description': 'Mehndi ceremony and designs'},
          {'name': 'Wedding Ceremony', 'description': 'Main wedding rituals and vows'},
          {'name': 'Reception Party', 'description': 'Reception and celebration'},
        ];

    // ═══════════════════════════════════════════════════════════════
    // 4. FAMILY & KIDS
    // ═══════════════════════════════════════════════════════════════
      case 'Family & Kids':
        return [
          {'name': 'Family Portrait', 'description': 'Complete family group photos'},
          {'name': 'Baby Newborn', 'description': 'Newborn and baby photography'},
          {'name': 'Kids Children', 'description': 'Children and kids photos'},
          {'name': 'Maternity Pregnancy', 'description': 'Pregnancy and maternity shoots'},
          {'name': 'Grandparents', 'description': 'Elderly and grandparent portraits'},
          {'name': 'Siblings', 'description': 'Brother sister and sibling photos'},
        ];

    // ═══════════════════════════════════════════════════════════════
    // 5. FESTIVALS & OCCASIONS
    // ═══════════════════════════════════════════════════════════════
      case 'Festivals & Occasions':
        return [
          {'name': 'Diwali', 'description': 'Festival of lights celebration'},
          {'name': 'Holi', 'description': 'Festival of colors celebration'},
          {'name': 'Eid', 'description': 'Eid celebration and greetings'},
          {'name': 'Christmas', 'description': 'Christmas and holiday season'},
          {'name': 'Birthday', 'description': 'Birthday party and celebration'},
          {'name': 'Independence Day', 'description': 'Patriotic national celebrations'},
        ];

    // ═══════════════════════════════════════════════════════════════
    // 6. BUSINESS & MARKETING
    // ═══════════════════════════════════════════════════════════════
      case 'Business & Marketing':
        return [
          {'name': 'Logo Design', 'description': 'Brand logos and identity'},
          {'name': 'Business Poster', 'description': 'Corporate posters and banners'},
          {'name': 'Social Ads', 'description': 'Social media advertisements'},
          {'name': 'Presentation', 'description': 'Business presentation slides'},
          {'name': 'Office Corporate', 'description': 'Office and workspace photos'},
          {'name': 'Team Photos', 'description': 'Team and staff photography'},
        ];

    // ═══════════════════════════════════════════════════════════════
    // 7. PRODUCT & E-COMMERCE
    // ═══════════════════════════════════════════════════════════════
      case 'Product & E-commerce':
        return [
          {'name': 'Electronics Gadgets', 'description': 'Phones laptops tech products'},
          {'name': 'Fashion Apparel', 'description': 'Clothing and fashion items'},
          {'name': 'Beauty Cosmetics', 'description': 'Makeup skincare beauty products'},
          {'name': 'Jewelry Watches', 'description': 'Jewelry and luxury watches'},
          {'name': 'Home Furniture', 'description': 'Home decor and furniture'},
          {'name': 'Packaging Design', 'description': 'Product packaging and boxes'},
        ];

    // ═══════════════════════════════════════════════════════════════
    // 8. ART STYLES
    // ═══════════════════════════════════════════════════════════════
      case 'Art Styles':
        return [
          {'name': 'Photorealistic', 'description': 'Ultra realistic photography style'},
          {'name': 'Anime Manga', 'description': 'Japanese anime and manga art'},
          {'name': '3D Render', 'description': 'Three dimensional rendered art'},
          {'name': 'Watercolor', 'description': 'Soft watercolor painting style'},
          {'name': 'Oil Painting', 'description': 'Classic oil painting style'},
          {'name': 'Pixel Art', 'description': 'Retro pixel based digital art'},
        ];

    // ═══════════════════════════════════════════════════════════════
    // 9. NATURE & LANDSCAPES
    // ═══════════════════════════════════════════════════════════════
      case 'Nature & Landscapes':
        return [
          {'name': 'Mountains', 'description': 'Mountain ranges and peaks'},
          {'name': 'Beach Ocean', 'description': 'Coastal beaches and seas'},
          {'name': 'Forest Jungle', 'description': 'Dense forests and jungles'},
          {'name': 'Sunset Sunrise', 'description': 'Golden hour sky photos'},
          {'name': 'Waterfall River', 'description': 'Waterfalls and flowing rivers'},
          {'name': 'Night Sky Stars', 'description': 'Starry night and galaxies'},
        ];

    // ═══════════════════════════════════════════════════════════════
    // 10. ANIMALS & PETS
    // ═══════════════════════════════════════════════════════════════
      case 'Animals & Pets':
        return [
          {'name': 'Dogs Puppies', 'description': 'Dog breeds and puppies'},
          {'name': 'Cats Kittens', 'description': 'Cat breeds and kittens'},
          {'name': 'Birds', 'description': 'Colorful birds and parrots'},
          {'name': 'Wildlife', 'description': 'Wild animals in nature'},
          {'name': 'Pet Portraits', 'description': 'Professional pet photography'},
          {'name': 'Cute Animals', 'description': 'Adorable baby animals'},
        ];

    // ═══════════════════════════════════════════════════════════════
    // 11. FOOD & RESTAURANT
    // ═══════════════════════════════════════════════════════════════
      case 'Food & Restaurant':
        return [
          {'name': 'Indian Cuisine', 'description': 'Traditional Indian food'},
          {'name': 'Fast Food', 'description': 'Burgers pizza and fast food'},
          {'name': 'Desserts Sweets', 'description': 'Cakes desserts and sweets'},
          {'name': 'Coffee Cafe', 'description': 'Coffee drinks and cafe vibes'},
          {'name': 'Restaurant Setup', 'description': 'Restaurant interiors and setup'},
          {'name': 'Chef Cooking', 'description': 'Chef and cooking scenes'},
        ];

    // ═══════════════════════════════════════════════════════════════
    // 12. FASHION & LIFESTYLE
    // ═══════════════════════════════════════════════════════════════
      case 'Fashion & Lifestyle':
        return [
          {'name': 'High Fashion', 'description': 'Editorial fashion photography'},
          {'name': 'Street Style', 'description': 'Urban streetwear fashion'},
          {'name': 'Indian Ethnic', 'description': 'Saree kurta traditional wear'},
          {'name': 'Fitness Gym', 'description': 'Gym and fitness lifestyle'},
          {'name': 'Beauty Makeup', 'description': 'Beauty and makeup looks'},
          {'name': 'Accessories', 'description': 'Bags shoes and accessories'},
        ];

    // ═══════════════════════════════════════════════════════════════
    // 13. VEHICLES & TRAVEL
    // ═══════════════════════════════════════════════════════════════
      case 'Vehicles & Travel':
        return [
          {'name': 'Sports Cars', 'description': 'Luxury sports and supercars'},
          {'name': 'Motorcycles', 'description': 'Bikes and motorcycles'},
          {'name': 'Travel India', 'description': 'Indian travel destinations'},
          {'name': 'World Travel', 'description': 'International travel spots'},
          {'name': 'Adventure', 'description': 'Adventure and outdoor travel'},
          {'name': 'Hotels Resorts', 'description': 'Luxury hotels and resorts'},
        ];

    // ═══════════════════════════════════════════════════════════════
    // 14. SOCIAL MEDIA
    // ═══════════════════════════════════════════════════════════════
      case 'Social Media':
        return [
          {'name': 'Instagram Post', 'description': 'Instagram feed posts'},
          {'name': 'YouTube Thumbnail', 'description': 'Video thumbnails'},
          {'name': 'Reels Cover', 'description': 'Reels and TikTok covers'},
          {'name': 'Quote Posts', 'description': 'Motivational quote designs'},
          {'name': 'Story Templates', 'description': 'Instagram story templates'},
          {'name': 'Meme Templates', 'description': 'Funny meme templates'},
        ];

    // ═══════════════════════════════════════════════════════════════
    // 15. PHOTO ENHANCEMENT
    // ═══════════════════════════════════════════════════════════════
      case 'Photo Enhancement':
        return [
          {'name': 'Upscale HD', 'description': 'Upscale images to 4K 8K'},
          {'name': 'Old Photo Restore', 'description': 'Restore damaged old photos'},
          {'name': 'Background Remove', 'description': 'Remove or change background'},
          {'name': 'Face Enhance', 'description': 'Enhance facial features'},
          {'name': 'Color Correction', 'description': 'Fix colors and lighting'},
          {'name': 'Style Transfer', 'description': 'Change photo to art style'},
        ];

    // ═══════════════════════════════════════════════════════════════
    // 16. AI TOOLS & PLATFORMS
    // ═══════════════════════════════════════════════════════════════
      case 'AI Tools & Platforms':
        return [
          {'name': 'Midjourney', 'description': 'Midjourney advanced prompts'},
          {'name': 'DALL-E 3', 'description': 'OpenAI DALL-E 3 prompts'},
          {'name': 'Stable Diffusion', 'description': 'Stable Diffusion XL tips'},
          {'name': 'Leonardo AI', 'description': 'Leonardo AI techniques'},
          {'name': 'Kling Runway', 'description': 'Kling and Runway video AI'},
          {'name': 'Flux Ideogram', 'description': 'Flux and Ideogram tips'},
        ];

    // ═══════════════════════════════════════════════════════════════
    // 17. GAMING & ESPORTS (Human Transformation)
    // ═══════════════════════════════════════════════════════════════
      case 'Gaming & Esports':
        return [
          {'name': 'Cyberpunk Hero', 'description': 'Transform yourself into a neon-lit futuristic character'},
          {'name': 'Fantasy Warrior', 'description': 'Recreate your photo as a medieval knight or RPG hero'},
          {'name': 'Esports Streamer', 'description': 'Place yourself in a professional pro-gaming setup'},
          {'name': 'GTA Style Avatar', 'description': 'Turn your portrait into a classic game-art loading screen'},
          {'name': '3D Game Character', 'description': 'Convert your face into a high-quality 3D animated avatar'},
          {'name': 'Superhero Suit', 'description': 'See yourself wearing cinematic powerful superhero armor'},
        ];

    // ═══════════════════════════════════════════════════════════════
    // 18. ARCHITECTURE & INTERIORS (Human Lifestyle)
    // ═══════════════════════════════════════════════════════════════
      case 'Architecture & Interiors':
        return [
          {'name': 'Luxury Penthouse', 'description': 'See yourself living in a high-end modern skyscraper'},
          {'name': 'Executive Office', 'description': 'You in a powerful CEO cabin with a city view'},
          {'name': 'Dream Home Life', 'description': 'Relaxing in a cozy, aesthetic minimalist living room'},
          {'name': 'Vintage Royal Hall', 'description': 'You standing in a grand historical palace interior'},
          {'name': 'Creative Studio', 'description': 'Working in a professional artistic and modern workspace'},
          {'name': 'Outdoor Balcony', 'description': 'You enjoying a sunset on a luxury terrace garden'},
        ];

      default:
        return [
          {'name': 'General', 'description': 'General content'},
        ];
    }
  }
}
