import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const VentrixApp());
}

class VentrixApp extends StatelessWidget {
  const VentrixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VENTRIX TECHNOLOGIES',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        primaryColor: const Color(0xFF00D4FF),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00D4FF),
          secondary: Color(0xFF9C27B0),
          tertiary: Color(0xFF673AB7),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late VideoPlayerController _heroVideoController;
  late VideoPlayerController _startupVideoController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeVideos();
  }

  void _initializeVideos() {
    // Hero background video - placeholder path
    _heroVideoController = VideoPlayerController.asset('assets/videos/hero_background.mp4')
      ..initialize().then((_) {
        _heroVideoController.setLooping(true);
        _heroVideoController.play();
        setState(() {});
      });

    // Startup innovation video - placeholder path
    _startupVideoController = VideoPlayerController.asset('assets/videos/startup_innovation.mp4')
      ..initialize().then((_) {
        _startupVideoController.setLooping(true);
        _startupVideoController.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _heroVideoController.dispose();
    _startupVideoController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Floating particles background
          CircularParticle(
            awayRadius: 80,
            numberOfParticles: 50,
            speedOfParticles: 1,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            onTapAnimation: true,
            particleColor: Colors.cyan.withOpacity(0.1),
            awayAnimationDuration: const Duration(milliseconds: 600),
            maxParticleSize: 8,
            isRandSize: true,
            isRandomColor: false,
            awayAnimationCurve: Curves.easeInOut,
            enableHover: true,
            hoverColor: Colors.white,
            hoverRadius: 90,
          ),
          // Main content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(videoController: _heroVideoController),
                const AboutSection(),
                const ServicesSection(),
                const TechStackSection(),
                StartupInnovationSection(videoController: _startupVideoController),
                const PortfolioSection(),
                const CareersSection(),
                const BlogSection(),
                const ContactSection(),
                const Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  final VideoPlayerController videoController;

  const HeroSection({super.key, required this.videoController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          // Background video
          Positioned.fill(
            child: videoController.value.isInitialized
                ? VideoPlayer(videoController)
                : Container(color: Colors.black),
          ),
          // Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated gradient text
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF00D4FF), Color(0xFF9C27B0), Color(0xFF673AB7)],
                  ).createShader(bounds),
                  child: const Text(
                    'VENTRIX TECHNOLOGIES',
                    style: TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn(duration: 1000.ms).scale(delay: 200.ms),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Powering the Future of Digital Innovation',
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white70,
                  ),
                ).animate().fadeIn(delay: 800.ms),
                const SizedBox(height: 40),
                const Text(
                  'Building next-generation digital platforms, AI-powered products, and scalable tech solutions for startups and enterprises.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white60,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 1200.ms),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00D4FF),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        shadowColor: const Color(0xFF00D4FF).withOpacity(0.5),
                        elevation: 10,
                      ),
                      child: const Text('Start Your Project'),
                    ).animate().fadeIn(delay: 1600.ms).scale(),
                    const SizedBox(width: 20),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF00D4FF), width: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Explore Our Solutions', style: TextStyle(color: Color(0xFF00D4FF))),
                    ).animate().fadeIn(delay: 1800.ms).scale(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
      child: Column(
        children: [
          const Text(
            'About Ventrix',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
          ).animate().fadeIn().slideY(begin: 0.3),
          const SizedBox(height: 50),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Our Vision',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF00D4FF)),
                    ).animate().fadeIn(delay: 200.ms),
                    const SizedBox(height: 20),
                    const Text(
                      'To be the leading force in digital transformation, empowering businesses with cutting-edge AI, cloud solutions, and innovative technologies that shape the future.',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ).animate().fadeIn(delay: 400.ms),
                  ],
                ),
              ),
              const SizedBox(width: 50),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Our Mission',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF9C27B0)),
                    ).animate().fadeIn(delay: 600.ms),
                    const SizedBox(height: 20),
                    const Text(
                      'To deliver exceptional digital solutions that drive innovation, accelerate growth, and create lasting impact for startups and enterprises worldwide.',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ).animate().fadeIn(delay: 800.ms),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 1000.ms);
  }
}

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      'AI Solutions',
      'SaaS Development',
      'Mobile App Development',
      'Web Platforms',
      'Cloud & DevOps',
      'UI/UX Design',
      'Startup MVP Development',
      'Digital Transformation',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
      color: Colors.black.withOpacity(0.5),
      child: Column(
        children: [
          const Text(
            'Our Services',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
          ).animate().fadeIn().slideY(begin: 0.3),
          const SizedBox(height: 50),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.2,
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              return ServiceCard(
                title: services[index],
                index: index,
              ).animate().fadeIn(delay: (index * 100).ms).scale();
            },
          ),
        ],
      ),
    ).animate().fadeIn(duration: 1000.ms);
  }
}

class ServiceCard extends StatefulWidget {
  final String title;
  final int index;

  const ServiceCard({super.key, required this.title, required this.index});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? const Color(0xFF00D4FF) : Colors.white.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: const Color(0xFF00D4FF).withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  )
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.code,
                size: 48,
                color: _isHovered ? const Color(0xFF00D4FF) : Colors.white70,
              ),
              const SizedBox(height: 20),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _isHovered ? const Color(0xFF00D4FF) : Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ).animate(target: _isHovered ? 1 : 0).scaleXY(end: 1.05),
    );
  }
}

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final techStack = [
      {'name': 'React', 'icon': Icons.code},
      {'name': 'Next.js', 'icon': Icons.web},
      {'name': 'Flutter', 'icon': Icons.mobile_friendly},
      {'name': 'Node.js', 'icon': Icons.settings},
      {'name': 'Python', 'icon': Icons.language},
      {'name': 'AWS', 'icon': Icons.cloud},
      {'name': 'Firebase', 'icon': Icons.storage},
      {'name': 'AI / ML', 'icon': Icons.smart_toy},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
      child: Column(
        children: [
          const Text(
            'Technology Stack',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
          ).animate().fadeIn().slideY(begin: 0.3),
          const SizedBox(height: 50),
          Wrap(
            spacing: 40,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: techStack.map((tech) {
              return TechIcon(
                name: tech['name'] as String,
                icon: tech['icon'] as IconData,
              ).animate().fadeIn(delay: 200.ms).scale();
            }).toList(),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 1000.ms);
  }
}

class TechIcon extends StatefulWidget {
  final String name;
  final IconData icon;

  const TechIcon({super.key, required this.name, required this.icon});

  @override
  State<TechIcon> createState() => _TechIconState();
}

class _TechIconState extends State<TechIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: _isHovered ? const Color(0xFF00D4FF).withOpacity(0.2) : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isHovered ? const Color(0xFF00D4FF) : Colors.white.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Icon(
              widget.icon,
              size: 40,
              color: _isHovered ? const Color(0xFF00D4FF) : Colors.white70,
            ),
          ).animate(target: _isHovered ? 1 : 0).scaleXY(end: 1.1),
          const SizedBox(height: 10),
          Text(
            widget.name,
            style: TextStyle(
              fontSize: 14,
              color: _isHovered ? const Color(0xFF00D4FF) : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

class StartupInnovationSection extends StatelessWidget {
  final VideoPlayerController videoController;

  const StartupInnovationSection({super.key, required this.videoController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          // Background video
          Positioned.fill(
            child: videoController.value.isInitialized
                ? VideoPlayer(videoController)
                : Container(color: Colors.black),
          ),
          // Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF00D4FF), Color(0xFF9C27B0), Color(0xFF673AB7)],
                  ).createShader(bounds),
                  child: const Text(
                    '"We Build The Future With Code"',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn(duration: 1000.ms).scale(),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9C27B0),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: const Color(0xFF9C27B0).withOpacity(0.5),
                    elevation: 10,
                  ),
                  child: const Text('Join the Waitlist'),
                ).animate().fadeIn(delay: 800.ms).scale(),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 1000.ms);
  }
}

class PortfolioSection extends StatelessWidget {
  const PortfolioSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      {'title': 'AI-Powered SaaS Platform', 'description': 'Scalable cloud solution with ML integration'},
      {'title': 'FinTech Mobile App', 'description': 'Secure payment processing with real-time analytics'},
      {'title': 'E-commerce Platform', 'description': 'Next-gen shopping experience with AR features'},
      {'title': 'IoT Dashboard', 'description': 'Real-time monitoring and control system'},
      {'title': 'Healthcare App', 'description': 'Patient management with telemedicine features'},
      {'title': 'EdTech Platform', 'description': 'Interactive learning with AI personalization'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
      color: Colors.black.withOpacity(0.3),
      child: Column(
        children: [
          const Text(
            'Portfolio / Projects',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
          ).animate().fadeIn().slideY(begin: 0.3),
          const SizedBox(height: 50),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.5,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return ProjectCard(
                title: projects[index]['title']!,
                description: projects[index]['description']!,
                index: index,
              ).animate().fadeIn(delay: (index * 150).ms).scale();
            },
          ),
        ],
      ),
    ).animate().fadeIn(duration: 1000.ms);
  }
}

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final int index;

  const ProjectCard({super.key, required this.title, required this.description, required this.index});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.white.withOpacity(0.15) : Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? const Color(0xFF00D4FF) : Colors.white.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: const Color(0xFF00D4FF).withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  )
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.image, size: 60, color: Colors.white54),
              ),
              const SizedBox(height: 20),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _isHovered ? const Color(0xFF00D4FF) : Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ).animate(target: _isHovered ? 1 : 0).scaleXY(end: 1.02),
    );
  }
}

class CareersSection extends StatelessWidget {
  const CareersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
      child: Column(
        children: [
          const Text(
            'Careers',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
          ).animate().fadeIn().slideY(begin: 0.3),
          const SizedBox(height: 50),
          const Text(
            'Join Our Team of Innovators',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF00D4FF)),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 30),
          const Text(
            'We\'re looking for passionate developers, designers, and innovators who want to build the future. Work on cutting-edge projects, collaborate with industry leaders, and make a real impact in the world of technology.',
            style: TextStyle(fontSize: 18, color: Colors.white70),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 400.ms),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF673AB7),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('View Open Positions'),
          ).animate().fadeIn(delay: 600.ms).scale(),
        ],
      ),
    ).animate().fadeIn(duration: 1000.ms);
  }
}

class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    final articles = [
      {'title': 'The Future of AI in Business', 'excerpt': 'Exploring how artificial intelligence is transforming industries...', 'date': '2024-01-15'},
      {'title': 'Building Scalable SaaS Platforms', 'excerpt': 'Best practices for creating robust cloud-based solutions...', 'date': '2024-01-10'},
      {'title': 'UX Design Trends for 2024', 'excerpt': 'Latest trends in user experience design and interaction...', 'date': '2024-01-05'},
      {'title': 'DevOps for Modern Teams', 'excerpt': 'Streamlining development and operations with cutting-edge tools...', 'date': '2023-12-28'},
      {'title': 'Mobile App Security', 'excerpt': 'Protecting user data in an increasingly connected world...', 'date': '2023-12-20'},
      {'title': 'Cloud Migration Strategies', 'excerpt': 'Successfully moving to cloud infrastructure...', 'date': '2023-12-15'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
      color: Colors.black.withOpacity(0.5),
      child: Column(
        children: [
          const Text(
            'Blog / Insights',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
          ).animate().fadeIn().slideY(begin: 0.3),
          const SizedBox(height: 50),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.2,
            ),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return ArticleCard(
                title: articles[index]['title']!,
                excerpt: articles[index]['excerpt']!,
                date: articles[index]['date']!,
                index: index,
              ).animate().fadeIn(delay: (index * 150).ms).scale();
            },
          ),
        ],
      ),
    ).animate().fadeIn(duration: 1000.ms);
  }
}

class ArticleCard extends StatefulWidget {
  final String title;
  final String excerpt;
  final String date;
  final int index;

  const ArticleCard({super.key, required this.title, required this.excerpt, required this.date, required this.index});

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.white.withOpacity(0.12) : Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? const Color(0xFF00D4FF) : Colors.white.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: const Color(0xFF00D4FF).withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 3,
                  )
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.date,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _isHovered ? const Color(0xFF00D4FF) : Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                widget.excerpt,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ).animate(target: _isHovered ? 1 : 0).scaleXY(end: 1.02),
    );
  }
}

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _companyController = TextEditingController();
  final _projectController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _companyController.dispose();
    _projectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
      child: Column(
        children: [
          const Text(
            'Contact / Waitlist',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
          ).animate().fadeIn().slideY(begin: 0.3),
          const SizedBox(height: 50),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: const TextStyle(color: Colors.white70),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white30),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF00D4FF)),
                          ),
                        ),
                        validator: (value) => value?.isEmpty ?? true ? 'Please enter your name' : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: const TextStyle(color: Colors.white70),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white30),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF00D4FF)),
                          ),
                        ),
                        validator: (value) => value?.isEmpty ?? true ? 'Please enter your email' : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _companyController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Company',
                          labelStyle: const TextStyle(color: Colors.white70),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white30),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF00D4FF)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _projectController,
                        style: const TextStyle(color: Colors.white),
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: 'Project Idea',
                          labelStyle: const TextStyle(color: Colors.white70),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white30),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF00D4FF)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Handle form submission
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00D4FF),
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          shadowColor: const Color(0xFF00D4FF).withOpacity(0.5),
                          elevation: 10,
                        ),
                        child: const Text('Start Building With Ventrix'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ).animate().fadeIn(delay: 200.ms).scale(),
        ],
      ),
    ).animate().fadeIn(duration: 1000.ms);
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
      color: Colors.black.withOpacity(0.8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'VENTRIX TECHNOLOGIES',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => launchUrl(Uri.parse('https://twitter.com/ventrixtech')),
                    icon: const Icon(Icons.alternate_email, color: Colors.white70),
                  ),
                  IconButton(
                    onPressed: () => launchUrl(Uri.parse('https://linkedin.com/company/ventrix-tech')),
                    icon: const Icon(Icons.business, color: Colors.white70),
                  ),
                  IconButton(
                    onPressed: () => launchUrl(Uri.parse('https://github.com/ventrix-tech')),
                    icon: const Icon(Icons.code, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Services',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {},
                    child: const Text('AI Solutions', style: TextStyle(color: Colors.white70)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('SaaS Development', style: TextStyle(color: Colors.white70)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Mobile Apps', style: TextStyle(color: Colors.white70)),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Company',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {},
                    child: const Text('About', style: TextStyle(color: Colors.white70)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Careers', style: TextStyle(color: Colors.white70)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Blog', style: TextStyle(color: Colors.white70)),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'hello@ventrixtech.com',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '+1 (555) 123-4567',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Divider(color: Colors.white24),
          const SizedBox(height: 20),
          const Text(
            '© 2024 Ventrix Technologies. All rights reserved.',
            style: TextStyle(color: Colors.white54),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }
}
