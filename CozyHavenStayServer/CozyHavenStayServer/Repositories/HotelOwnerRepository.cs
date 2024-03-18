﻿using CozyHavenStayServer.Context;
using CozyHavenStayServer.Interfaces;
using CozyHavenStayServer.Models;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Linq.Expressions;

namespace CozyHavenStayServer.Repositories
{
    public class HotelOwnerRepository : IRepository<HotelOwner>
    {
        private readonly CozyHeavenStayContext _context;
        public HotelOwnerRepository(CozyHeavenStayContext context)
        {
            _context = context;
            
        }

        public async Task<HotelOwner> CreateAsync(HotelOwner dbRecord)
        {
            _context.Add(dbRecord);
            await _context.SaveChangesAsync();
            return dbRecord;
        }

        public async Task<bool> DeleteAsync(HotelOwner dbRecord)
        {
            _context.Remove(dbRecord);
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<List<HotelOwner>> GetAllAsync()
        {
            return await _context.HotelOwners
            .Include(u => u.Hotels)
                    .ThenInclude(h => h.HotelImages)
                .Include(u => u.Hotels)
                    .ThenInclude(h => h.Rooms)
                        .ThenInclude(r => r.RoomImages)
                .Include(u => u.Hotels)
                    .ThenInclude(h => h.Reviews).ThenInclude(r => r.User) 
                .AsSplitQuery()
            .ToListAsync();
        }

        public async Task<HotelOwner> GetAsync(Expression<Func<HotelOwner, bool>> filter, bool useNoTracking = false)
        {
            if (useNoTracking)
                return await _context.HotelOwners.AsNoTracking().Where(filter)
                .Include(u => u.Hotels)
                    .ThenInclude(h => h.HotelImages)
                .Include(u => u.Hotels)
                    .ThenInclude(h => h.Rooms)
                        .ThenInclude(r => r.RoomImages)
                .Include(u => u.Hotels)
                    .ThenInclude(h => h.Reviews).ThenInclude(r => r.User) 
                .AsSplitQuery()
                .FirstOrDefaultAsync();
            else
                return await _context.HotelOwners.Where(filter)
                .Include(u => u.Hotels)
                    .ThenInclude(h => h.HotelImages)
                .Include(u => u.Hotels)
                    .ThenInclude(h => h.Rooms)
                        .ThenInclude(r => r.RoomImages)
                .Include(u => u.Hotels)
                    .ThenInclude(h => h.Reviews).ThenInclude(r => r.User)
                .AsSplitQuery()
                .FirstOrDefaultAsync();
        }

        public async Task<HotelOwner> UpdateAsync(HotelOwner dbRecord)
        {
            _context.HotelOwners.Update(dbRecord);
            await _context.SaveChangesAsync();
            return dbRecord;
        }
    }
}