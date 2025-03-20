import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: const Text('Profile'),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () => _navigateToSettings(context),
                ),
              ],
            ),
            SliverToBoxAdapter(child: _buildProfileHeader(context)),
            SliverToBoxAdapter(child: _buildQuickActions(context)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final sections = _getSections(context);
                  return sections[index];
                },
                childCount: _getSections(context).length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.pushNamed(context, '/settings');
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://picsum.photos/200'),
          ),
          const SizedBox(height: 16),
          const Text('John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('john.doe@example.com',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey)),
          const SizedBox(height: 8),
          TextButton(onPressed: () {}, child: const Text('Edit Profile')),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildQuickActionItem(
              context, 'Orders', '12', Icons.shopping_bag_outlined),
          _buildQuickActionItem(
              context, 'Wishlist', '24', Icons.favorite_border),
          _buildQuickActionItem(
              context, 'Coupons', '8', Icons.local_offer_outlined),
          _buildQuickActionItem(context, 'Reviews', '6', Icons.star_border),
        ],
      ),
    );
  }

  List<Widget> _getSections(BuildContext context) {
    return [
      _buildSection(context, 'Orders', [
        _buildListTile(context, 'My Orders', Icons.shopping_bag_outlined,
            onTap: () {}),
        _buildListTile(context, 'My Returns', Icons.assignment_return_outlined,
            onTap: () {}),
        _buildListTile(context, 'Cancelled Orders', Icons.cancel_outlined,
            onTap: () {}),
      ]),
      _buildSection(context, 'Profile Settings', [
        _buildListTile(context, 'Edit Profile', Icons.person_outline,
            onTap: () {}),
        _buildListTile(context, 'Saved Addresses', Icons.location_on_outlined,
            onTap: () {}),
        _buildListTile(context, 'Payment Methods', Icons.payment_outlined,
            onTap: () {}),
      ]),
      _buildSection(context, 'Preferences', [
        _buildListTile(context, 'Notifications', Icons.notifications_outlined,
            onTap: () {}),
        _buildThemeToggle(context),
        _buildListTile(context, 'Language', Icons.language_outlined,
            trailing: const Text('English'), onTap: () {}),
      ]),
      _buildSection(context, 'Help & Support', [
        _buildListTile(context, 'Customer Support', Icons.headset_mic_outlined,
            onTap: () {}),
        _buildListTile(context, 'FAQs', Icons.help_outline, onTap: () {}),
        _buildListTile(context, 'Privacy Policy', Icons.privacy_tip_outlined,
            onTap: () {}),
      ]),
    ];
  }

  Widget _buildQuickActionItem(
      BuildContext context, String title, String count, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          child: Icon(icon, color: Theme.of(context).primaryColor),
        ),
        const SizedBox(height: 8),
        Text(count,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                )),
      ],
    );
  }

  Widget _buildSection(
      BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ),
        ...children,
        const Divider(),
      ],
    );
  }

  Widget _buildListTile(BuildContext context, String title, IconData icon,
      {Widget? trailing, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      leading: const Icon(Icons.dark_mode_outlined),
      title: const Text('Dark Mode'),
      trailing: Switch(
        value: isDark,
        onChanged: (value) => AdaptiveTheme.of(context).setThemeMode(
            value ? AdaptiveThemeMode.dark : AdaptiveThemeMode.light),
      ),
    );
  }
}
