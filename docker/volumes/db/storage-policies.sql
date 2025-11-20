-- Storage RLS Policies Initialization
-- This script creates default RLS policies for storage.objects table
-- to allow public uploads and reads for all buckets by default

BEGIN;

-- Drop existing policies if they exist (to make this idempotent)
DROP POLICY IF EXISTS "Allow authenticated uploads" ON storage.objects;
DROP POLICY IF EXISTS "Allow authenticated reads" ON storage.objects;
DROP POLICY IF EXISTS "Allow authenticated updates" ON storage.objects;
DROP POLICY IF EXISTS "Allow authenticated deletes" ON storage.objects;

-- Create policy to allow authenticated and anon users to upload files
CREATE POLICY "Allow authenticated uploads"
ON storage.objects FOR INSERT
TO authenticated, anon
WITH CHECK (true);

-- Create policy to allow authenticated and anon users to read files
CREATE POLICY "Allow authenticated reads"
ON storage.objects FOR SELECT
TO authenticated, anon
USING (true);

-- Create policy to allow authenticated and anon users to update files
CREATE POLICY "Allow authenticated updates"
ON storage.objects FOR UPDATE
TO authenticated, anon
USING (true)
WITH CHECK (true);

-- Create policy to allow authenticated and anon users to delete files
CREATE POLICY "Allow authenticated deletes"
ON storage.objects FOR DELETE
TO authenticated, anon
USING (true);

-- Log completion
DO $$
BEGIN
    RAISE NOTICE 'Storage RLS policies initialized successfully';
END $$;

COMMIT;