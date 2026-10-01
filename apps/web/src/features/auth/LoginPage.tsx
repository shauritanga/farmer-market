import { useState, type FormEvent } from 'react';
import { useNavigate } from 'react-router-dom';

import { useAuth } from '../../core/auth/AuthContext';
import { Button } from '../../core/components/Button';

export function LoginPage() {
  const { login } = useAuth();
  const navigate = useNavigate();

  const [phoneNumber, setPhoneNumber] = useState('');
  const [password, setPassword] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function handleSubmit(event: FormEvent) {
    event.preventDefault();
    setError(null);
    setIsLoading(true);
    try {
      await login(phoneNumber, password);
      navigate('/', { replace: true });
    } catch {
      setError('Invalid phone number or password, or you lack admin access.');
    } finally {
      setIsLoading(false);
    }
  }

  return (
    <div
      style={{
        minHeight: '100svh',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
      }}
    >
      <form
        onSubmit={handleSubmit}
        style={{
          width: 320,
          display: 'flex',
          flexDirection: 'column',
          gap: 12,
        }}
      >
        <h1 style={{ fontSize: 20, marginBottom: 8 }}>Fama Admin</h1>

        <label style={{ display: 'flex', flexDirection: 'column', gap: 4 }}>
          Phone number
          <input
            required
            type="tel"
            value={phoneNumber}
            onChange={(event) => setPhoneNumber(event.target.value)}
            style={inputStyle}
          />
        </label>

        <label style={{ display: 'flex', flexDirection: 'column', gap: 4 }}>
          Password
          <input
            required
            type="password"
            value={password}
            onChange={(event) => setPassword(event.target.value)}
            style={inputStyle}
          />
        </label>

        {error && <p style={{ color: 'var(--color-danger)', fontSize: 13 }}>{error}</p>}

        <Button type="submit" isLoading={isLoading}>
          Sign in
        </Button>
      </form>
    </div>
  );
}

const inputStyle = {
  padding: '8px 10px',
  borderRadius: 'var(--radius)',
  border: '1px solid var(--color-border)',
  background: 'var(--color-surface)',
  color: 'var(--color-text)',
};
