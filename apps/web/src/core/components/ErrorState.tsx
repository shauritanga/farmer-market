import { Alert01Icon } from '@hugeicons/core-free-icons';

import { Button } from './Button';
import { Icon } from './Icon';

interface ErrorStateProps {
  message: string;
  onRetry?: () => void;
}

export function ErrorState({ message, onRetry }: ErrorStateProps) {
  return (
    <div style={{ padding: 32, textAlign: 'center' }}>
      <Icon icon={Alert01Icon} size={28} color="var(--color-danger)" />
      <p style={{ color: 'var(--color-danger)', margin: '8px 0 12px' }}>
        {message}
      </p>
      {onRetry && (
        <Button variant="secondary" onClick={onRetry}>
          Retry
        </Button>
      )}
    </div>
  );
}
