import 'package:flutter/material.dart';
import 'package:unping_task/generated/assets.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maher Adel Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF0a192f),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({Key? key}) : super(key: key);

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _heroAnimController;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _heroAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  void _scrollToSection(double offset) {
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _buildHeroSection(),
                _buildAboutSection(),
                _buildSkillsSection(),
                _buildProjectsSection(),
                _buildExperienceSection(),
                _buildContactSection(),
              ],
            ),
          ),
          _buildNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF0a192f).withOpacity(0.9),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(-20 * (1 - value), 0),
                    child: child,
                  ),
                );
              },
              child: const Text(
                'MA',
                style: TextStyle(
                  color: Color(0xFF64ffda),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                _navButton('About', 800, 0),
                _navButton('Skills', 1600, 100),
                _navButton('Projects', 2400, 200),
                _navButton('Experience', 3200, 300),
                _navButton('Contact', 4000, 400),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _navButton(String text, double offset, int delay) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800 + delay),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, -20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextButton(
          onPressed: () => _scrollToSection(offset),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 700,
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeTransition(
            opacity: _fadeController,
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(-0.5, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _heroAnimController,
                      curve: Curves.easeOut,
                    ),
                  ),
              child: const Text(
                "Hello, I'm",
                style: TextStyle(
                  color: Color(0xFF64ffda),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          FadeTransition(
            opacity: _fadeController,
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(-0.5, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _heroAnimController,
                      curve: Interval(0.2, 1.0, curve: Curves.easeOut),
                    ),
                  ),
              child: const Text(
                'Maher Adel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          FadeTransition(
            opacity: _fadeController,
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(-0.5, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _heroAnimController,
                      curve: Interval(0.3, 1.0, curve: Curves.easeOut),
                    ),
                  ),
              child: const Text(
                'Flutter Developer',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          FadeTransition(
            opacity: _fadeController,
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(-0.5, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _heroAnimController,
                      curve: Interval(0.4, 1.0, curve: Curves.easeOut),
                    ),
                  ),
              child: const SizedBox(
                width: 600,
                child: Text(
                  'I\'m a mobile developer specializing in building exceptional digital experiences. Currently, I\'m focused on building accessible, human-centered mobile applications.',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 18,
                    height: 1.6,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          Row(
            children: [
              FadeTransition(
                opacity: _fadeController,
                child: SlideTransition(
                  position:
                  Tween<Offset>(
                    begin: const Offset(-0.5, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _heroAnimController,
                      curve: Interval(0.5, 1.0, curve: Curves.easeOut),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: (){
                      launchUrl(Uri.parse('https://drive.google.com/file/d/1NbHG6nyYbZBZ2LgJou0fy1Ztxpml6Mje/view?usp=sharing'));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: const Color(0xFF64ffda),
                      side: const BorderSide(color: Color(0xFF64ffda), width: 2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'View CV',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 20,),
                        Icon(Icons.arrow_forward_ios_rounded, color:const Color(0xFF64ffda) ,)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 30,),
              FadeTransition(
                opacity: _fadeController,
                child: SlideTransition(
                  position:
                      Tween<Offset>(
                        begin: const Offset(-0.5, 0),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: _heroAnimController,
                          curve: Interval(0.5, 1.0, curve: Curves.easeOut),
                        ),
                      ),
                  child: ElevatedButton(
                    onPressed: () => _scrollToSection(4000),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: const Color(0xFF64ffda),
                      side: const BorderSide(color: Color(0xFF64ffda), width: 2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Get In Touch',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 100),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('About Me'),
                  const SizedBox(height: 30),
                  const Text(
                    'Hello! I\'m Maher, a mobile developer passionate about creating innovative and user-friendly applications. My journey in mobile development started back in 2022, and I\'ve had the privilege of working on various exciting projects.',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 18,
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'I specialize in Flutter development and have experience building cross-platform applications that are both beautiful and performant. I\'m always eager to learn new technologies and best practices.',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 18,
                      height: 1.8,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 100),
            Expanded(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.8, end: 1.0),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Transform.scale(scale: value, child: child);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF64ffda),
                      width: 2,
                    ),
                  ),
                  child: Image.asset(Assets.imagesMyImage),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsSection() {
    final skills = [
      'Flutter',
      'Dart',
      'Firebase',
      'REST APIs',
      'Git & GitHub ',
      'UI/UX',
      'State Management',
      'Bloc',
      'Cubit',
      'OOP',
      'FCM Notifications',
      'Google Maps',
      'Pusher',
      'Https',
      'Dio',
      'Postman',
      'MVVM',
      'Clean Architecture',
      'CI/CD',
      'Adaptive & custom UI',
      'Asana',
      'Trello',
      'Jira',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Skills & Technologies'),
          const SizedBox(height: 50),
          Wrap(
            spacing: 15,
            runSpacing: 15,
            children: List.generate(skills.length, (index) {
              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 500 + (index * 50)),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.scale(
                      scale: 0.8 + (0.2 * value),
                      child: child,
                    ),
                  );
                },
                child: _SkillChip(skill: skills[index]),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsSection() {
    // TODO: Add your Mostaql portfolio projects here
    // Replace this list with your actual projects from Mostaql
    final projects = [
      {
        'title': 'BWW Store',
        'description':
            'Online Multi-Vendors Store with vendor dashboard, product management, and order tracking.',
        'tech': [
          'Flutter',
          'Firebase',
          'REST APIs',
          'Pusher Notifications',
          'SMS Provider',
          'MVVM',
          'Clean Architecture',
        ],
        'category': 'E-Commerce',
        'status': 'Live',
        'playStoreUrl':
            'https://play.google.com/store/apps/details?id=com.bwwstore.app&pcampaignid=web_share',
        'appStoreUrl': 'https://apps.apple.com/eg/app/bww-store/id6753354187',
      },
      {
        'title': 'GeniePT - AI personal Trainer',
        'description':
            'An AI-powered app that creates personalized workout and diet plans, tracks your progress regularly, provides fitness articles tailored to your needs, and offers daily live support.It helps Users to achieve their health and fitness goals through a smart app that combines cutting-edge AI technology with advanced training methods.',
        'tech': [
          'Flutter',
          'REST APIs',
          'Cubit',
          'FCM Notifications',
          'Sign in with Google',
          'Sign in with Apple',
          'Sign in with e-mail',
          'Integrating with AI Model',
          'Clean Architecture',
        ],
        'category': 'Health',
        'status': 'Live',
        'playStoreUrl':
            'https://play.google.com/store/apps/details?id=com.geniept2.geniept2&pcampaignid=web_share',
        'appStoreUrl': 'https://apps.apple.com/eg/app/geniept/id6744561364',
      },
      {
        'title': 'Saytara - Delegate Management',
        'description':
            'Specialized application for delegates in supermarket chains, streamlining daily workflows and improving efficiency.',
        'tech': ['Flutter', 'REST APIs', 'State Management'],
        'category': 'Business',
        'status': 'Live',
        'playStoreUrl':
            'https://play.google.com/store/apps/details?id=darwinz.ai.saytara.saytara&pcampaignid=web_share',
      },
      {
        'title': 'Ufeed HR System',
        'description':
            'Complete web-based HR management system built with Flutter Flow for employee management and workflows.',
        'tech': ['Flutter Flow', 'Firebase', 'Cloud Functions'],
        'category': 'Enterprise',
        'status': 'Live',
      },
      // TODO: Add more projects from your Mostaql portfolio here
      // Example format:
      // {
      //   'title': 'Project Name',
      //   'description': 'Project description from Mostaql',
      //   'tech': ['Tech1', 'Tech2', 'Tech3'],
      //   'category': 'Category',
      //   'status': 'Live/In Progress',
      // },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Projects'),
          const SizedBox(height: 20),
          const Text(
            'A selection of projects I\'ve worked on',
            style: TextStyle(color: Colors.white60, fontSize: 16, height: 1.6),
          ),
          const SizedBox(height: 50),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            children: List.generate(projects.length, (index) {
              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 800 + (index * 200)),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 50 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: _EnhancedProjectCard(
                  project: projects[index],
                  onTap: () => _showProjectDetailsBottomSheet(projects[index]),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceSection() {
    final experiences = [
      {
        'title': 'Flutter Developer',
        'company': 'العلا للأعمال المحدودة (ABC Company)',
        'period': 'Feb 2025 - Present',
        'description':
            "As a Flutter Developer at العلا للأعمال المحدودة (ABC Company), I am responsible for designing, developing, and maintaining a suite of mobile applications, including the company's flagship shopping platform BWW and the multi-vendor application BWW Store. My work focuses on delivering scalable architecture, high performance, and seamless user experiences across both Android and iOS. I also play a key role in building and enhancing the vendor dashboard within the mobile app, enabling vendors to efficiently manage products, orders, and store operations directly from their devices. This role involves close collaboration with backend, design, and product teams to ensure smooth integrations, robust functionality, and continuous feature improvements that support the company's business growth.",
      },
      {
        'title': 'Flutter Developer',
        'company': 'TheDar.AI',
        'period': 'Jan 2024 – Nov 2024',
        'description':
            "At TheDar.AI, My role includes contributing to Saytara, a specialized application that streamlines daily workflows for delegates operating across major supermarket chains, improving efficiency and communication. In addition to mobile development, I also utilized Flutter Flow to build a complete web-based HR system Ufeed, enabling the company to manage employees, workflows, and internal processes more effectively. I focus on delivering clean architecture, optimized performance, and scalable solutions while collaborating closely with product, design, and backend teams to ensure smooth delivery and continuous improvements.",
      },
      {
        'title': 'Freelancer Flutter Developer',
        'company': 'Mostaql',
        'period': 'Mar 2023 - Present',
        'description':
            'As a Freelance Flutter Developer, I have successfully developed and deployed 10+ cross-platform mobile applications for clients across the Arab World. Each project was tailored to specific business needs, resulting in improved client engagement. My responsibilities included designing user-friendly interfaces, integrating APIs, and ensuring delivery within agreed timelines.',
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Experience'),
          const SizedBox(height: 50),
          ...List.generate(experiences.length, (index) {
            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 800 + (index * 200)),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(-50 * (1 - value), 0),
                    child: child,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 3,
                      height: 100,
                      color: const Color(0xFF64ffda),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            experiences[index]['title'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${experiences[index]['company']} • ${experiences[index]['period']}',
                            style: const TextStyle(
                              color: Color(0xFF64ffda),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            experiences[index]['description'] as String,
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 16,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 100),
        child: Center(
          child: Column(
            children: [
              const Text(
                'Get In Touch',
                style: TextStyle(
                  color: Color(0xFF64ffda),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Let\'s Work Together',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              const SizedBox(
                width: 600,
                child: Text(
                  'I\'m Always open for discussing new projects \n creative ideas or opportunities to be part of your vision',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 18,
                    height: 1.8,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  launchUrl(Uri.parse('mailto:maheradel451@gmail.com'));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: const Color(0xFF64ffda),
                  side: const BorderSide(color: Color(0xFF64ffda), width: 2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  'Say Hello',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialIcon(Assets.imagesGithub, 0, () {
                    launchUrl(Uri.parse('https://github.com/maherade'));
                  },Colors.white),
                  _socialIcon(Assets.imagesLinkedin, 100, () {
                    launchUrl(
                      Uri.parse(
                        'https://www.linkedin.com/in/maher-adel-234722191/',
                      ),
                    );
                  },Colors.white),
                  _socialIcon(Assets.imagesMail, 200, () {
                    launchUrl(Uri.parse('mailto:maheradel451@gmail.com'));
                  },Colors.white),
                  _socialIcon(Assets.imagesTelephone, 300, () {
                    launchUrl(Uri.parse('tel:+201554583937'));
                  },Colors.white),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                '© 2025 Maher Adel. Built with Flutter',
                style: TextStyle(color: Colors.white30, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(String icon, int delay, void Function()? onTap,Color color) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800 + delay),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(scale: 0.5 + (0.5 * value), child: child),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: InkWell(
            onTap: onTap,
            radius: 20,
            child: Image.asset(
              icon,
              fit: BoxFit.fill,
              height: 30,
              width: 30,
              color: color,
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Row(
      children: [
        const Text(
          '-',
          style: TextStyle(
            color: Color(0xFF64ffda),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(child: Container(height: 1, color: Colors.white10)),
      ],
    );
  }

  void _showProjectDetailsBottomSheet(Map<String, dynamic> project) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF112240),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    project['title'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  color: Colors.white70,
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (project['category'] != null)
              Text(
                project['category'] as String,
                style: const TextStyle(
                  color: Color(0xFF64ffda),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            const SizedBox(height: 20),
            Text(
              project['description'] as String,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 16,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 30),
            if (project['playStoreUrl'] != null ||
                project['appStoreUrl'] != null)
              const Text(
                'Available on:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 20),
            if (project['playStoreUrl'] != null)
              _StoreButton(
                icon: Assets.imagesGooglePlay,
                label: 'Google Play Store',
                onTap: () {
                  launchUrl(Uri.parse(project['playStoreUrl']));
                  print('Opening Play Store: ${project['playStoreUrl']}');
                },
              ),
            if (project['playStoreUrl'] != null &&
                project['appStoreUrl'] != null)
              const SizedBox(height: 15),
            if (project['appStoreUrl'] != null)
              _StoreButton(
                icon: Assets.imagesAppStore,
                label: 'Apple App Store',
                onTap: () {
                  launchUrl(Uri.parse(project['appStoreUrl']));
                  print('Opening App Store: ${project['appStoreUrl']}');
                },
              ),
            if (project['playStoreUrl'] == null &&
                project['appStoreUrl'] == null)
              SizedBox.shrink(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _heroAnimController.dispose();
    _fadeController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class _StoreButton extends StatefulWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const _StoreButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_StoreButton> createState() => _StoreButtonState();
}

class _StoreButtonState extends State<_StoreButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: _isHovered
                ? const Color(0xFF64ffda).withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHovered ? const Color(0xFF64ffda) : Colors.white10,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                widget.icon,
                color: _isHovered ? const Color(0xFF64ffda) : Colors.white70,
                height: 30,
                width: 30,
              ),
              const SizedBox(width: 15),
              Text(
                widget.label,
                style: TextStyle(
                  color: _isHovered ? const Color(0xFF64ffda) : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: _isHovered ? const Color(0xFF64ffda) : Colors.white70,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String skill;

  const _SkillChip({required this.skill});

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: _isHovered
              ? const Color(0xFF64ffda).withOpacity(0.1)
              : const Color(0xFF112240),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: _isHovered ? const Color(0xFF64ffda) : Colors.white10,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: _isHovered ? const Color(0xFF64ffda) : Colors.white60,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.skill,
              style: TextStyle(
                color: _isHovered ? const Color(0xFF64ffda) : Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EnhancedProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final VoidCallback onTap;

  const _EnhancedProjectCard({required this.project, required this.onTap});

  @override
  State<_EnhancedProjectCard> createState() => _EnhancedProjectCardState();
}

class _EnhancedProjectCardState extends State<_EnhancedProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 500,
          padding: const EdgeInsets.all(30),
          transform: Matrix4.translationValues(0, _isHovered ? -10 : 0, 0),
          decoration: BoxDecoration(
            color: const Color(0xFF112240),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHovered ? const Color(0xFF64ffda) : Colors.white10,
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFF64ffda).withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.project['status'] != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF64ffda).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF64ffda),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        widget.project['status'] as String,
                        style: const TextStyle(
                          color: Color(0xFF64ffda),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  Icon(
                    Icons.open_in_new,
                    color: _isHovered
                        ? const Color(0xFF64ffda)
                        : Colors.white60,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (widget.project['category'] != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    widget.project['category'] as String,
                    style: const TextStyle(
                      color: Color(0xFF64ffda),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              Text(
                widget.project['title'] as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                widget.project['description'] as String,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 15,
                  height: 1.6,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: (widget.project['tech'] as List<String>).map((tech) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF64ffda).withOpacity(0.05),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      tech,
                      style: const TextStyle(
                        color: Color(0xFF64ffda),
                        fontSize: 13,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
