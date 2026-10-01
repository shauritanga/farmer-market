import type { ButtonHTMLAttributes } from 'react';

interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  isLoading?: boolean;
  variant?: 'primary' | 'secondary';
}

export function Button({
  isLoading = false,
  variant = 'primary',
  disabled,
  children,
  style,
  ...rest
}: ButtonProps) {
  const isPrimary = variant === 'primary';

  return (
    <button
      {...rest}
      disabled={disabled || isLoading}
      style={{
        font: 'inherit',
        padding: '10px 18px',
        borderRadius: 'var(--radius)',
        border: isPrimary ? 'none' : '1px solid var(--color-border)',
        background: isPrimary ? 'var(--color-primary)' : 'var(--color-surface)',
        color: isPrimary ? 'var(--color-primary-contrast)' : 'var(--color-text)',
        cursor: disabled || isLoading ? 'not-allowed' : 'pointer',
        opacity: disabled || isLoading ? 0.7 : 1,
        ...style,
      }}
    >
      {isLoading ? 'Loading…' : children}
    </button>
  );
}
