<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'bubbleco_wpdb');

/** MySQL database username */
define('DB_USER', 'bubblecoup');

/** MySQL database password */
define('DB_PASSWORD', 'bubblecouppass');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '*aHEe9q?!`_tl+R[CWcMhRZAZzoE=+6Ftv[j,OM59T)wQ%kI{?&#C;d@q-2|AWjK');
define('SECURE_AUTH_KEY',  'x,<3E>,l!$- k{AT@ R|YQ^Dg|xW]@IE*gYm@uc-S[@>^aU8[FSs4hH:8owxfsyu');
define('LOGGED_IN_KEY',    '10JFb,?EUiwY;ZzsEg;p|wY:gllw@Nx+pWg4$KNZ3t,T{O>Qa&^q:9zW6)yTAek*');
define('NONCE_KEY',        '`C(qH=zY=UNOHSq|*yV.8*hUxbETu?G~en|y=(aq:;0V~a8G~#z)y?!-5)-J+zjk');
define('AUTH_SALT',        't^|;5^*a?W1M+[Y !E$e%1T6[atFY=pDmg8]T|?dr&.7a&|9&i)Wk=+@{Yk,EU$y');
define('SECURE_AUTH_SALT', 'k/lrO!qNcr_e7BkQtc334anuQa11XZ$r?HI:i=GpK06G}Xmbsk<@LW)mb~F<MSdx');
define('LOGGED_IN_SALT',   ']5LI+j==BCQgMJonvTyO~Ssq`1]$+XZwxvM$vSfbv2xUhOQ?-YcrrG;Z1@wrH5$>');
define('NONCE_SALT',       'hf(Xx8o7dKYpszvN}=*>{)AhTUF$+VdYO=A `;-4K )i[%V)w4MX#nWUzI4(C7}z');
/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
?>
