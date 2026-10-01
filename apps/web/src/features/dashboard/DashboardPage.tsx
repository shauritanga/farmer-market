import { useQuery } from '@tanstack/react-query';

import { EmptyState } from '../../core/components/EmptyState';
import { ErrorState } from '../../core/components/ErrorState';
import { LoadingState } from '../../core/components/LoadingState';
import { StatusBadge } from '../../core/components/StatusBadge';
import { fetchActiveProduceListings } from './produceApi';

export function DashboardPage() {
  const { data, isLoading, isError, refetch } = useQuery({
    queryKey: ['produce-listings', 'active'],
    queryFn: fetchActiveProduceListings,
  });

  return (
    <div>
      <h1 style={{ fontSize: 18, marginBottom: 16 }}>Active produce listings</h1>

      {isLoading && <LoadingState />}
      {isError && (
        <ErrorState message="Could not load produce listings." onRetry={refetch} />
      )}
      {data && data.length === 0 && (
        <EmptyState message="No active produce listings yet." />
      )}
      {data && data.length > 0 && (
        <table style={{ width: '100%', borderCollapse: 'collapse' }}>
          <thead>
            <tr style={{ textAlign: 'left', borderBottom: '1px solid var(--color-border)' }}>
              <th style={cellStyle}>Commodity</th>
              <th style={cellStyle}>Farmer</th>
              <th style={cellStyle}>Quantity</th>
              <th style={cellStyle}>Location</th>
              <th style={cellStyle}>Status</th>
            </tr>
          </thead>
          <tbody>
            {data.map((listing) => (
              <tr key={listing.id} style={{ borderBottom: '1px solid var(--color-border)' }}>
                <td style={cellStyle}>{listing.commodity.name}</td>
                <td style={cellStyle}>{listing.farmer.user.name}</td>
                <td style={cellStyle}>
                  {listing.quantityAvailable} {listing.unit}
                </td>
                <td style={cellStyle}>{listing.location}</td>
                <td style={cellStyle}>
                  <StatusBadge label={listing.status} tone="success" />
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}

const cellStyle = { padding: '8px 12px' };
