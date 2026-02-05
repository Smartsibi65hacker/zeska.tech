import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';

void main() {
  runApp(const LuxuryLoginApp());
}

class LuxuryLoginApp extends StatelessWidget {
  const LuxuryLoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZESKA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF000000),
        fontFamily: 'SF Pro Display',
      ),
      home: const LuxuryLoginScreen(),
    );
  }
}

class LuxuryLoginScreen extends StatefulWidget {
  const LuxuryLoginScreen({super.key});

  @override
  State<LuxuryLoginScreen> createState() => _LuxuryLoginScreenState();
}

class _LuxuryLoginScreenState extends State<LuxuryLoginScreen>
    with TickerProviderStateMixin {
  bool isLogin = true;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool hasError = false;
  bool isLoading = false;
  
  late AnimationController _floatingController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _shakeController;
  late AnimationController _pulseController;
  late AnimationController _particleController;
  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    _floatingController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..forward();
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
    
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    
    _particleController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _shakeController.dispose();
    _pulseController.dispose();
    _particleController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _toggleMode() {
    setState(() {
      isLogin = !isLogin;
      hasError = false;
      _slideController.reset();
      _slideController.forward();
    });
  }

  void _handleSubmit() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1500));

    // Simulate error for demo (in production, check actual credentials)
    if (_passwordController.text != "correct_password") {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      
      // Trigger shake animation
      _shakeController.reset();
      _shakeController.forward().then((_) {
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              hasError = false;
            });
          }
        });
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // Success - navigate or show success
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated gradient background with mesh effect
          _buildAnimatedBackground(),
          
          // Particle system
          _buildParticleSystem(),
          
          // Floating orbs with enhanced glow
          _buildFloatingOrbs(),
          
          // Ambient light effects
          _buildAmbientLights(),
          
          // Main content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: FadeTransition(
                    opacity: _fadeController,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),
                        
                        // Logo and title
                        _buildLogo(),
                        
                        const SizedBox(height: 80),
                        
                        // Login/Signup form with shake animation
                        _buildFormCard(),
                        
                        const SizedBox(height: 32),
                        
                        // Social login
                        _buildSocialLogin(),
                        
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 0.3, 0.6, 1.0],
              colors: [
                Color.lerp(
                  const Color(0xFF0D0D0D),
                  const Color(0xFF1A1A1A),
                  _floatingController.value,
                )!,
                const Color(0xFF000000),
                Color.lerp(
                  const Color(0xFF1A0F0A),
                  const Color(0xFF0F0A05),
                  _floatingController.value,
                )!,
                const Color(0xFF000000),
              ],
            ),
          ),
          child: CustomPaint(
            painter: MeshGradientPainter(_floatingController.value),
            size: Size.infinite,
          ),
        );
      },
    );
  }

  Widget _buildParticleSystem() {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlePainter(_particleController.value),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildAmbientLights() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              top: -100,
              left: -100,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Color(0xFFFFD700).withOpacity(0.15 * _pulseController.value),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -150,
              right: -150,
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Color(0xFFC9A961).withOpacity(0.12 * (1 - _pulseController.value)),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFloatingOrbs() {
    return Stack(
      children: [
        _buildOrb(
          top: 120,
          left: -120,
          size: 350,
          colors: [
            const Color(0xFFFFD700).withOpacity(0.2),
            const Color(0xFFD4AF37).withOpacity(0.1),
            Colors.transparent,
          ],
          duration: 6,
          offset: 30,
        ),
        _buildOrb(
          bottom: 100,
          right: -100,
          size: 400,
          colors: [
            const Color(0xFFC9A961).withOpacity(0.18),
            const Color(0xFFFFD700).withOpacity(0.08),
            Colors.transparent,
          ],
          duration: 7,
          offset: 40,
        ),
        _buildOrb(
          top: 350,
          right: 30,
          size: 220,
          colors: [
            const Color(0xFFD4AF37).withOpacity(0.15),
            Colors.transparent,
          ],
          duration: 5,
          offset: 25,
        ),
        _buildOrb(
          bottom: 300,
          left: 40,
          size: 180,
          colors: [
            const Color(0xFFFFD700).withOpacity(0.12),
            Colors.transparent,
          ],
          duration: 8,
          offset: 20,
        ),
      ],
    );
  }

  Widget _buildOrb({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required List<Color> colors,
    required int duration,
    required double offset,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: AnimatedBuilder(
        animation: _floatingController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              math.sin(_floatingController.value * 2 * math.pi) * offset,
              math.cos(_floatingController.value * 2 * math.pi) * offset,
            ),
            child: Transform.scale(
              scale: 1.0 + (math.sin(_floatingController.value * math.pi) * 0.1),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: colors,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors.first.withOpacity(0.3),
                      blurRadius: 100,
                      spreadRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogo() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFD700).withOpacity(0.9 + (_pulseController.value * 0.1)),
                    Color(0xFFD4AF37).withOpacity(0.8 + (_pulseController.value * 0.1)),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFFFD700).withOpacity(0.4 + (_pulseController.value * 0.2)),
                    blurRadius: 40 + (_pulseController.value * 20),
                    spreadRadius: 5 + (_pulseController.value * 5),
                  ),
                  BoxShadow(
                    color: Color(0xFFD4AF37).withOpacity(0.3),
                    blurRadius: 80,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    size: 50,
                    color: const Color(0xFF000000),
                  ),
                  Transform.rotate(
                    angle: _floatingController.value * 2 * math.pi,
                    child: Icon(
                      Icons.auto_awesome,
                      size: 50,
                      color: Color(0xFF000000).withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  Color(0xFFFFD700),
                  Color(0xFFFFF8DC),
                  Color(0xFFD4AF37),
                  Color(0xFFFFD700),
                ],
                stops: const [0.0, 0.3, 0.7, 1.0],
              ).createShader(bounds),
              child: Text(
                'ZESKA',
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w200,
                  letterSpacing: 16,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Color(0xFFFFD700).withOpacity(0.5),
                      blurRadius: 30,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color(0xFFD4AF37).withOpacity(0.3),
                  width: 1,
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.05),
                    Colors.white.withOpacity(0.02),
                  ],
                ),
              ),
              child: Text(
                'L U X U R Y   A C C E S S',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 4,
                  color: Color(0xFFD4AF37).withOpacity(0.8),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFormCard() {
    final shakeAnimation = Tween<double>(begin: 0, end: 10)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_shakeController);

    return AnimatedBuilder(
      animation: Listenable.merge([_slideController, _shakeController]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            math.sin(_shakeController.value * math.pi * 4) * shakeAnimation.value,
            0,
          ),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: _slideController,
              curve: Curves.easeOutCubic,
            )),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 480),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: hasError 
                      ? const Color(0xFFFF4444).withOpacity(0.6)
                      : const Color(0xFFD4AF37).withOpacity(0.3),
                  width: 1.5,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.08),
                    Colors.white.withOpacity(0.03),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: hasError
                        ? const Color(0xFFFF4444).withOpacity(0.3)
                        : const Color(0xFFFFD700).withOpacity(0.15),
                    blurRadius: 50,
                    spreadRadius: 5,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 60,
                    offset: const Offset(0, 30),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.05),
                          Colors.white.withOpacity(0.01),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        children: [
                          // Toggle buttons
                          _buildToggleButtons(),
                          
                          const SizedBox(height: 40),
                          
                          // Error message
                          if (hasError) _buildErrorMessage(),
                          
                          // Form fields
                          _buildTextField(
                            controller: _emailController,
                            label: 'Email Address',
                            icon: Icons.email_outlined,
                            enabled: !isLoading,
                          ),
                          
                          const SizedBox(height: 24),
                          
                          _buildTextField(
                            controller: _passwordController,
                            label: 'Password',
                            icon: Icons.lock_outline,
                            isPassword: true,
                            isVisible: isPasswordVisible,
                            enabled: !isLoading,
                            onToggleVisibility: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                          
                          if (!isLogin) ...[
                            const SizedBox(height: 24),
                            _buildTextField(
                              controller: _confirmPasswordController,
                              label: 'Confirm Password',
                              icon: Icons.lock_outline,
                              isPassword: true,
                              isVisible: isConfirmPasswordVisible,
                              enabled: !isLoading,
                              onToggleVisibility: () {
                                setState(() {
                                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
                                });
                              },
                            ),
                          ],
                          
                          if (isLogin) ...[
                            const SizedBox(height: 16),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: isLoading ? null : () {},
                                child: ShaderMask(
                                  shaderCallback: (bounds) => const LinearGradient(
                                    colors: [Color(0xFFFFD700), Color(0xFFD4AF37)],
                                  ).createShader(bounds),
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          
                          const SizedBox(height: 40),
                          
                          // Submit button
                          _buildSubmitButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFFF4444).withOpacity(0.15),
        border: Border.all(
          color: const Color(0xFFFF4444).withOpacity(0.5),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: const Color(0xFFFF6666),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Invalid credentials. Please try again.',
              style: TextStyle(
                color: const Color(0xFFFF8888),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButtons() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black.withOpacity(0.4),
        border: Border.all(
          color: const Color(0xFFD4AF37).withOpacity(0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: isLogin ? Alignment.centerLeft : Alignment.centerRight,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD700), Color(0xFFD4AF37)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFD700).withOpacity(0.6),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (!isLogin && !isLoading) _toggleMode();
                  },
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isLogin 
                            ? const Color(0xFF000000)
                            : Colors.white.withOpacity(0.5),
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (isLogin && !isLoading) _toggleMode();
                  },
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: !isLogin 
                            ? const Color(0xFF000000)
                            : Colors.white.withOpacity(0.5),
                        letterSpacing: 2,
                      ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    bool isVisible = false,
    bool enabled = true,
    VoidCallback? onToggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFD4AF37).withOpacity(0.25),
          width: 1.5,
        ),
        color: Colors.white.withOpacity(enabled ? 0.04 : 0.02),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFD700).withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        obscureText: isPassword && !isVisible,
        style: TextStyle(
          color: enabled ? Colors.white : Colors.white.withOpacity(0.5),
          fontSize: 15,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.white.withOpacity(enabled ? 0.6 : 0.4),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0xFFD4AF37).withOpacity(enabled ? 0.7 : 0.4),
            size: 22,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: const Color(0xFFD4AF37).withOpacity(enabled ? 0.7 : 0.4),
                    size: 22,
                  ),
                  onPressed: enabled ? onToggleVisibility : null,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: isLoading
            ? LinearGradient(
                colors: [
                  Color(0xFFD4AF37).withOpacity(0.5),
                  Color(0xFFFFD700).withOpacity(0.5),
                ],
              )
            : const LinearGradient(
                colors: [Color(0xFFFFD700), Color(0xFFFFF8DC), Color(0xFFFFD700)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
        boxShadow: isLoading
            ? []
            : [
                BoxShadow(
                  color: const Color(0xFFFFD700).withOpacity(0.6),
                  blurRadius: 30,
                  spreadRadius: 2,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: const Color(0xFFD4AF37).withOpacity(0.4),
                  blurRadius: 50,
                  spreadRadius: 5,
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : _handleSubmit,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF000000).withOpacity(0.5),
                      ),
                    ),
                  )
                : Text(
                    isLogin ? 'SIGN IN' : 'CREATE ACCOUNT',
                    style: const TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 3,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.white.withOpacity(0.2),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'OR CONTINUE WITH',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              icon: Icons.g_mobiledata,
              onTap: () {},
            ),
            const SizedBox(width: 16),
            _buildSocialButton(
              icon: Icons.apple,
              onTap: () {},
            ),
            const SizedBox(width: 16),
            _buildSocialButton(
              icon: Icons.facebook,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFD4AF37).withOpacity(0.25),
          width: 1.5,
        ),
        color: Colors.white.withOpacity(0.04),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onTap,
          customBorder: const CircleBorder(),
          child: Icon(
            icon,
            color: isLoading 
                ? const Color(0xFFD4AF37).withOpacity(0.3)
                : const Color(0xFFD4AF37),
            size: 32,
          ),
        ),
      ),
    );
  }
}

// Custom Painters for advanced effects

class MeshGradientPainter extends CustomPainter {
  final double animationValue;

  MeshGradientPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // Create mesh-like gradient effect
    for (int i = 0; i < 5; i++) {
      final offset = animationValue * 2 * math.pi;
      final x = size.width * (i / 5) + math.sin(offset + i) * 50;
      final y = size.height * 0.5 + math.cos(offset + i) * 100;

      paint.shader = RadialGradient(
        colors: [
          Color(0xFFFFD700).withOpacity(0.03),
          Colors.transparent,
        ],
        radius: 0.5,
      ).createShader(Rect.fromCircle(
        center: Offset(x, y),
        radius: 200,
      ));

      canvas.drawCircle(Offset(x, y), 200, paint);
    }
  }

  @override
  bool shouldRepaint(MeshGradientPainter oldDelegate) =>
      animationValue != oldDelegate.animationValue;
}

class ParticlePainter extends CustomPainter {
  final double animationValue;

  ParticlePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD4AF37).withOpacity(0.3)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Draw floating particles
    for (int i = 0; i < 20; i++) {
      final seed = i * 1000;
      final x = (math.sin(animationValue * 2 * math.pi + seed) * 0.5 + 0.5) * size.width;
      final y = ((animationValue + i / 20) % 1.0) * size.height;
      final opacity = (1 - (animationValue + i / 20) % 1.0) * 0.3;

      paint.color = Color(0xFFD4AF37).withOpacity(opacity);
      canvas.drawCircle(Offset(x, y), 2, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) =>
      animationValue != oldDelegate.animationValue;
}
