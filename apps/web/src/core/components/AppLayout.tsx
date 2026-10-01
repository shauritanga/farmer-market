import { LayoutDashboardIcon, Logout01Icon } from '@hugeicons/core-free-icons';
import type { ReactNode } from 'react';
import { NavLink } from 'react-router-dom';

import { useAuth } from '../auth/AuthContext';
import { Button } from './Button';
import { Icon } from './Icon';

const NAV_ITEMS = [{ to: '/', label: 'Dashboard', icon: LayoutDashboardIcon }];

export function AppLayout({ children }: { children: ReactNode }) {
  const { user, logout } = useAuth();

  return (
    <div style={{ display: 'flex', minHeight: '100svh' }}>
      <aside
        style={{
          width: 220,
          borderRight: '1px solid var(--color-border)',
          padding: 16,
          display: 'flex',
          flexDirection: 'column',
          gap: 16,
        }}
      >
        <strong>Fama Admin</strong>
        <nav style={{ display: 'flex', flexDirection: 'column', gap: 4 }}>
          {NAV_ITEMS.map((item) => (
            <NavLink
              key={item.to}
              to={item.to}
              style={({ isActive }) => ({
                display: 'flex',
                alignItems: 'center',
                gap: 8,
                padding: '8px 10px',
                borderRadius: 'var(--radius)',
                textDecoration: 'none',
                color: 'var(--color-text)',
                background: isActive ? 'var(--color-surface)' : 'transparent',
              })}
            >
              <Icon icon={item.icon} size={18} />
              {item.label}
            </NavLink>
          ))}
        </nav>
        <div style={{ marginTop: 'auto', fontSize: 13 }}>
          <div style={{ color: 'var(--color-text-muted)', marginBottom: 8 }}>
            {user?.name}
          </div>
          <Button
            variant="secondary"
            onClick={logout}
            style={{ display: 'flex', alignItems: 'center', gap: 8 }}
          >
            <Icon icon={Logout01Icon} size={16} />
            Sign out
          </Button>
        </div>
      </aside>
      <main style={{ flex: 1, padding: 24 }}>{children}</main>
    </div>
  );
}
