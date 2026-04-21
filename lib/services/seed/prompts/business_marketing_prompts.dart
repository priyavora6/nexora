// lib/services/seed/prompts/business_marketing_prompts.dart

class BusinessMarketingPrompts {
  static List<Map<String, String>> getPrompts(String subcategory) {
    switch (subcategory) {
      case 'Logo Design':
        return [
          {
            'title': 'Minimalist Tech Logo',
            'platform': 'Midjourney',
            'description': 'Clean modern tech startup logo',
            'text': 'Minimalist modern tech startup logo design, clean geometric shapes, letter N monogram, gradient blue to purple colors, white background, professional brand identity, vector style, Silicon Valley aesthetic, scalable design',
          },
          {
            'title': 'Restaurant Logo Vintage',
            'platform': 'DALL-E 3',
            'description': 'Vintage style restaurant branding',
            'text': 'Vintage restaurant logo design, hand-drawn style lettering, Indian cuisine theme, warm golden and maroon colors, decorative ornamental border, retro badge shape, premium dining establishment, professional branding',
          },
          {
            'title': 'Fitness Brand Logo',
            'platform': 'Ideogram',
            'description': 'Bold fitness brand identity',
            'text': 'Bold fitness brand logo, strong muscular lion mascot, text BEAST MODE in aggressive typography, black and red colors, gym and workout brand, powerful and energetic, sports logo design',
          },
          {
            'title': 'Fashion Brand Elegant',
            'platform': 'Leonardo AI',
            'description': 'Luxury fashion house logo',
            'text': 'Elegant luxury fashion brand logo, sophisticated serif typography, gold foil effect on black, minimalist crown symbol, high-end couture aesthetic, Gucci Chanel inspired elegance, premium brand identity',
          },
          {
            'title': 'Coffee Shop Logo',
            'platform': 'Stable Diffusion XL',
            'description': 'Cozy cafe brand logo',
            'text': 'Warm cozy coffee shop logo, steaming coffee cup illustration, circular badge design, brown and cream colors, hand lettered text BREW HOUSE, artisan cafe vibe, hipster aesthetic',
          },
          {
            'title': 'Real Estate Logo',
            'platform': 'Gemini AI',
            'description': 'Professional property logo',
            'text': 'Professional real estate company logo, modern house roof icon integrated with text, blue and silver colors, trustworthy corporate feel, property business branding, clean modern design',
          },
          {
            'title': 'Education Academy Logo',
            'platform': 'Adobe Firefly',
            'description': 'Academic institution branding',
            'text': 'Education academy logo design, open book with rising sun symbol, scholarly serif font, navy blue and gold colors, knowledge and growth theme, university style emblem, professional academic branding',
          },
          {
            'title': 'E-commerce App Logo',
            'platform': 'Midjourney',
            'description': 'Shopping app icon design',
            'text': 'Modern e-commerce shopping app logo, shopping bag with digital elements, vibrant gradient colors orange to pink, app icon ready, flat design style, memorable and recognizable, tech startup aesthetic',
          },
          {
            'title': 'Healthcare Clinic Logo',
            'platform': 'Flux AI',
            'description': 'Medical healthcare branding',
            'text': 'Healthcare clinic logo, modern medical cross with heart integration, calming green and white colors, trustworthy caring feel, hospital pharmacy branding, clean professional design',
          },
          {
            'title': 'Photography Studio Logo',
            'platform': 'DALL-E 3',
            'description': 'Creative studio branding',
            'text': 'Photography studio logo, camera lens aperture integrated with letter P, elegant script font, black and gold colors, creative professional branding, photography business identity',
          },
        ];

      case 'Business Poster':
        return [
          {
            'title': 'Grand Opening Poster',
            'platform': 'Midjourney',
            'description': 'Store grand opening announcement',
            'text': 'Eye-catching grand opening poster design, bold GRAND OPENING text, ribbon cutting ceremony graphic, celebratory confetti and balloons, special offers highlighted, date and location prominent, professional event marketing design',
          },
          {
            'title': 'Hiring Recruitment Poster',
            'platform': 'DALL-E 3',
            'description': 'We are hiring job poster',
            'text': 'Modern WE ARE HIRING recruitment poster, diverse professional team silhouettes, bold typography, corporate blue and white theme, job positions listed, QR code for application, professional HR marketing design',
          },
          {
            'title': 'Annual Sale Poster',
            'platform': 'Leonardo AI',
            'description': 'Mega sale event promotion',
            'text': 'Explosive MEGA SALE poster design, up to 70% off in bold red text, shopping elements flying, dynamic composition, urgency creating design, limited time offer banner, retail marketing poster',
          },
          {
            'title': 'Corporate Event Poster',
            'platform': 'Stable Diffusion XL',
            'description': 'Business conference announcement',
            'text': 'Professional business conference poster, ANNUAL SUMMIT 2025 title, keynote speaker photos, modern geometric design, blue gradient background, event details clearly laid out, corporate event marketing',
          },
          {
            'title': 'Product Launch Poster',
            'platform': 'Gemini AI',
            'description': 'New product launch announcement',
            'text': 'Dramatic product launch poster, COMING SOON text with spotlight effect, silhouette of new product, dark premium background, launch date prominent, building excitement and anticipation design',
          },
          {
            'title': 'Festive Offer Poster',
            'platform': 'Adobe Firefly',
            'description': 'Diwali sale promotion',
            'text': 'Diwali festive offer poster, traditional diya and rangoli elements, DIWALI DHAMAKA SALE text, gold and red colors, discount percentages, Indian festival shopping promotion design',
          },
          {
            'title': 'Workshop Training Poster',
            'platform': 'Midjourney',
            'description': 'Skills training workshop',
            'text': 'Professional skills workshop poster, FREE WORKSHOP bold text, digital marketing topic, instructor photo placeholder, date time venue details, registration QR code, educational event design',
          },
          {
            'title': 'Customer Testimonial Poster',
            'platform': 'Flux AI',
            'description': 'Client success stories display',
            'text': 'Customer testimonial poster design, 5-star rating graphic, client photo placeholder with quote, trustworthy blue and white design, company logo, social proof marketing material',
          },
          {
            'title': 'Franchise Opportunity',
            'platform': 'DALL-E 3',
            'description': 'Business franchise advertisement',
            'text': 'Business franchise opportunity poster, OWN YOUR BUSINESS text, investment details, growth chart graphic, success stories, professional business opportunity marketing design',
          },
          {
            'title': 'App Download Poster',
            'platform': 'Leonardo AI',
            'description': 'Mobile app promotion',
            'text': 'Mobile app download promotion poster, smartphone mockup showing app, DOWNLOAD NOW text, app store badges, feature highlights with icons, modern gradient design, app marketing material',
          },
        ];

      case 'Social Ads':
        return [
          {
            'title': 'Instagram Carousel Ad',
            'platform': 'Midjourney',
            'description': 'Multi-slide Instagram advertisement',
            'text': 'Professional Instagram carousel ad design, first slide with bold hook text, product showcase on clean background, benefit icons, swipe indicator, brand colors consistent, CTA button design, social media marketing',
          },
          {
            'title': 'Facebook Lead Gen Ad',
            'platform': 'DALL-E 3',
            'description': 'Lead generation Facebook ad',
            'text': 'Facebook lead generation ad, compelling headline about solving customer pain point, happy customer using product, before and after comparison, Sign Up Free CTA button, professional social ad design',
          },
          {
            'title': 'Google Display Banner',
            'platform': 'Leonardo AI',
            'description': 'Google display network banner',
            'text': 'Google display banner ad 728x90, clean product image, compelling offer text, brand logo, Learn More CTA button, professional banner advertising design, white background, attention grabbing',
          },
          {
            'title': 'YouTube Pre-roll Thumbnail',
            'platform': 'Stable Diffusion XL',
            'description': 'Video ad thumbnail',
            'text': 'YouTube pre-roll video ad thumbnail, shocked face reaction, bold yellow text overlay, product in hand, high contrast vibrant colors, click-worthy design, video advertising thumbnail',
          },
          {
            'title': 'LinkedIn Sponsored Post',
            'platform': 'Gemini AI',
            'description': 'Professional LinkedIn ad',
            'text': 'LinkedIn sponsored content ad, professional B2B service promotion, clean corporate design, industry statistics highlighted, company logo, Learn More button, business professional targeting',
          },
          {
            'title': 'WhatsApp Business Ad',
            'platform': 'Adobe Firefly',
            'description': 'WhatsApp promotional message',
            'text': 'WhatsApp business promotional image, product catalog style, special offer highlighted, order now with WhatsApp button, green accent colors, mobile-optimized vertical design',
          },
          {
            'title': 'Pinterest Shopping Ad',
            'platform': 'Midjourney',
            'description': 'Pinterest product pin design',
            'text': 'Pinterest shopping pin design, lifestyle product photography, aesthetic soft colors, price tag visible, Shop Now overlay, vertical 2:3 ratio, Pinterest-optimized marketing design',
          },
          {
            'title': 'Twitter Promoted Post',
            'platform': 'Flux AI',
            'description': 'Twitter engagement ad',
            'text': 'Twitter promoted post image, bold statement text, brand visual identity, engaging question format, hashtag visible, share-worthy design, social engagement marketing',
          },
          {
            'title': 'Story Ad Vertical',
            'platform': 'DALL-E 3',
            'description': 'Instagram Story advertisement',
            'text': 'Instagram Story ad design 9:16 vertical, full screen product showcase, swipe up CTA at bottom, bold text overlay, brand gradient background, immersive story advertising design',
          },
          {
            'title': 'Retargeting Banner',
            'platform': 'Leonardo AI',
            'description': 'Retargeting display ad',
            'text': 'Retargeting display ad, Forgot Something in Your Cart text, product image reminder, special discount code, urgency timer, Come Back CTA, conversion-focused remarketing design',
          },
        ];

      case 'Presentation':
        return [
          {
            'title': 'Startup Pitch Deck',
            'platform': 'Midjourney',
            'description': 'Investor pitch presentation slide',
            'text': 'Modern startup pitch deck slide design, clean minimal layout, large bold heading, key metrics in cards, gradient blue background, professional data visualization, investor presentation quality',
          },
          {
            'title': 'Sales Report Slide',
            'platform': 'DALL-E 3',
            'description': 'Quarterly sales performance',
            'text': 'Professional quarterly sales report presentation slide, bar chart showing growth, key numbers highlighted in boxes, corporate blue theme, company logo, clean business reporting design',
          },
          {
            'title': 'Team Introduction Slide',
            'platform': 'Leonardo AI',
            'description': 'Meet our team presentation',
            'text': 'Meet Our Team presentation slide, circular photo placeholders for team members, name and designation below each, modern grid layout, corporate design, professional team showcase',
          },
          {
            'title': 'Product Roadmap Slide',
            'platform': 'Stable Diffusion XL',
            'description': 'Product development timeline',
            'text': 'Product roadmap timeline presentation slide, horizontal timeline with milestones, icons for each phase, past present future sections, modern colorful design, tech product planning visual',
          },
          {
            'title': 'Market Analysis Slide',
            'platform': 'Gemini AI',
            'description': 'Market research presentation',
            'text': 'Market analysis presentation slide, pie chart showing market share, competitor comparison table, growth opportunity highlighted, professional dark theme, data-driven business presentation',
          },
          {
            'title': 'SWOT Analysis Slide',
            'platform': 'Adobe Firefly',
            'description': 'Strategic SWOT framework',
            'text': 'SWOT analysis presentation slide, four quadrant layout, Strengths Weaknesses Opportunities Threats, color coded sections green yellow orange red, strategic planning visual design',
          },
          {
            'title': 'Financial Summary Slide',
            'platform': 'Midjourney',
            'description': 'Revenue and profit summary',
            'text': 'Financial summary presentation slide, revenue chart trending upward, profit margin indicators, key financial KPIs in dashboard style, professional accounting design, investor-ready layout',
          },
          {
            'title': 'Thank You End Slide',
            'platform': 'Flux AI',
            'description': 'Presentation closing slide',
            'text': 'Thank You presentation closing slide, elegant typography, contact information, social media handles, company logo centered, subtle gradient background, professional farewell slide design',
          },
          {
            'title': 'Case Study Slide',
            'platform': 'DALL-E 3',
            'description': 'Client success case study',
            'text': 'Case study presentation slide, before and after metrics, client logo placeholder, challenge solution result format, testimonial quote, professional case study layout',
          },
          {
            'title': 'Process Flow Slide',
            'platform': 'Leonardo AI',
            'description': 'Business process workflow',
            'text': 'Business process flow presentation slide, step by step horizontal flow chart, numbered circles connected by arrows, icon for each step, modern clean design, workflow visualization',
          },
        ];

      case 'Office Corporate':
        return [
          {
            'title': 'Modern Open Office',
            'platform': 'Midjourney',
            'description': 'Contemporary open plan workspace',
            'text': 'Modern open plan office space, Indian tech company, employees working at standing desks, large windows with city view, plants and greenery, collaborative workspace, warm natural lighting, corporate photography',
          },
          {
            'title': 'CEO Corner Office',
            'platform': 'DALL-E 3',
            'description': 'Executive office interior',
            'text': 'Luxurious CEO corner office, floor to ceiling windows with city skyline, mahogany desk, leather executive chair, awards on shelf, Indian corporate executive environment, premium office photography',
          },
          {
            'title': 'Meeting Room Discussion',
            'platform': 'Leonardo AI',
            'description': 'Team in conference room',
            'text': 'Indian corporate team in glass-walled conference room, whiteboard with strategy notes, engaged discussion, laptops open, professional attire, modern meeting room, business photography',
          },
          {
            'title': 'Startup Coworking Space',
            'platform': 'Stable Diffusion XL',
            'description': 'Young startup team workspace',
            'text': 'Vibrant Indian startup coworking space, young entrepreneurs working, bean bags and standing desks, motivational wall quotes, colorful modern interior, creative energy, startup culture photography',
          },
          {
            'title': 'Reception Area',
            'platform': 'Gemini AI',
            'description': 'Corporate office lobby',
            'text': 'Elegant corporate office reception area, company logo on wall, modern furniture, receptionist greeting visitor, marble flooring, professional welcoming atmosphere, commercial interior photography',
          },
          {
            'title': 'Server Room Tech',
            'platform': 'Adobe Firefly',
            'description': 'Data center server room',
            'text': 'High-tech server room, rows of server racks with blue LED lights, Indian IT engineer monitoring systems, cables organized perfectly, data center technology photography',
          },
          {
            'title': 'Cafeteria Break Area',
            'platform': 'Midjourney',
            'description': 'Office pantry and break room',
            'text': 'Modern office cafeteria and break area, Indian employees enjoying lunch together, fresh food counter, coffee machine, relaxed social atmosphere, workplace wellness photography',
          },
          {
            'title': 'Training Workshop Room',
            'platform': 'Flux AI',
            'description': 'Corporate training session',
            'text': 'Corporate training room, Indian trainer presenting to employees, projector screen with slides, U-shaped seating, note-taking participants, professional development session photography',
          },
          {
            'title': 'Work From Home Setup',
            'platform': 'DALL-E 3',
            'description': 'Remote work home office',
            'text': 'Professional work from home setup, Indian professional on video call, dual monitors, ergonomic chair, organized desk, bookshelf background, remote work lifestyle photography',
          },
          {
            'title': 'Office Celebration',
            'platform': 'Leonardo AI',
            'description': 'Team celebrating achievement',
            'text': 'Indian office team celebrating project success, cake cutting, balloons and decorations, diverse happy team, congratulations banner, workplace culture, corporate celebration photography',
          },
        ];

      case 'Team Photos':
        return [
          {
            'title': 'Professional Team Grid',
            'platform': 'Midjourney',
            'description': 'Company team headshot grid',
            'text': 'Professional corporate team photo grid, individual headshots of diverse Indian team members, consistent background and lighting, corporate attire, friendly professional expressions, company website ready',
          },
          {
            'title': 'Casual Team Outdoor',
            'platform': 'DALL-E 3',
            'description': 'Team in outdoor setting',
            'text': 'Indian startup team casual group photo outdoors, company branded t-shirts, relaxed poses, office garden or park background, genuine smiles, team building spirit, lifestyle team photography',
          },
          {
            'title': 'Team at Whiteboard',
            'platform': 'Leonardo AI',
            'description': 'Collaborative brainstorming',
            'text': 'Indian team brainstorming at whiteboard, sticky notes and markers, engaged collaborative discussion, standing around whiteboard, creative problem solving, behind the scenes team photography',
          },
          {
            'title': 'Leadership Panel',
            'platform': 'Stable Diffusion XL',
            'description': 'C-suite executive team',
            'text': 'Indian corporate leadership team standing together, formal business attire, confidence and authority, modern office backdrop, executive leadership portrait, corporate governance photography',
          },
          {
            'title': 'Team Building Activity',
            'platform': 'Gemini AI',
            'description': 'Fun team bonding event',
            'text': 'Indian corporate team building activity, outdoor adventure, trust exercises, matching team jerseys, laughter and bonding, teamwork in action, corporate event photography',
          },
          {
            'title': 'Remote Team Video Call',
            'platform': 'Adobe Firefly',
            'description': 'Virtual team meeting',
            'text': 'Remote team video conference call, laptop screen showing grid of Indian team members faces, virtual meeting setup, distributed workforce, modern remote work team photo',
          },
          {
            'title': 'Sales Team Champions',
            'platform': 'Midjourney',
            'description': 'Award winning sales team',
            'text': 'Indian sales team with trophy and award certificates, celebratory group photo, business formal attire, company branding visible, achievement recognition, corporate success photography',
          },
          {
            'title': 'Engineering Team Lab',
            'platform': 'Flux AI',
            'description': 'Tech engineering team',
            'text': 'Indian engineering team in tech lab, surrounded by equipment and monitors, collaborative technical work, casual smart attire, innovation hub atmosphere, technology team photography',
          },
          {
            'title': 'Creative Design Team',
            'platform': 'DALL-E 3',
            'description': 'Design and creative team',
            'text': 'Indian creative design team, colorful workspace with artworks, designers at workstations, creative energy, trendy casual attire, design agency team photography',
          },
          {
            'title': 'New Joinee Welcome',
            'platform': 'Leonardo AI',
            'description': 'Welcoming new team member',
            'text': 'Indian team welcoming new employee, welcome banner and gifts, warm smiles, inclusive workplace culture, onboarding day, company culture photography',
          },
        ];

      default:
        return [];
    }
  }
}
