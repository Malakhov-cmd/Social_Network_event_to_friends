package com.example.EventManager.controller;

import com.example.EventManager.domain.Dialog;
import com.example.EventManager.domain.Room;
import com.example.EventManager.domain.User;
import com.example.EventManager.repos.DialogMessageRepo;
import com.example.EventManager.repos.DialogRepo;
import com.example.EventManager.repos.RoomRepo;
import com.example.EventManager.repos.UserRepo;
import com.example.EventManager.service.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
public class ProfileController {
    @Autowired
    private StorageService service;
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private DialogRepo dialogRepo;
    @Autowired
    private DialogMessageRepo dialogMessageRepo;
    @Autowired
    private RoomRepo roomRepo;

    @GetMapping("/profile/{user}")
    public String getProfile(@AuthenticationPrincipal User currentUser,
                             @PathVariable("user") User user,
                             Model model) {
        User userUpdated = userRepo.findByid(user.getId());

        List<User> friendList = userUpdated.getFriendList();

        boolean isFriend = false;

        for (User usr :
                friendList) {
            if (usr.getId().equals(currentUser.getId())) {
                isFriend = true;
            }
        }
        if (isFriend) {
            model.addAttribute("isFriend", true);
        } else {
            model.addAttribute("isFriend", false);
        }

        model.addAttribute("notRootNameSelected", false);
        model.addAttribute("userToCreateDialogNotFounded", false);
        model.addAttribute("friendList", friendList);
        model.addAttribute("user", userUpdated);
        model.addAttribute("requestFriendCount", userUpdated.getFriendRequestList().size());
        model.addAttribute("respondFriendCount", userUpdated.getFriendRespondList().size());
        model.addAttribute("FriendListSize", userUpdated.getFriendList().size());
        return "profile";
    }


    @PostMapping("/profile/{user}")
    public String postProfile(@AuthenticationPrincipal User currentUser,
                              @PathVariable("user") User user,
                              @RequestParam(required = false) Long friendId,
                              @RequestParam(required = false) Long userToDialog,
                              @RequestParam(required = false) String roomName,
                              @RequestParam(required = false) String strFriendToRoom,
                              Model model) {
        User futureFriend = userRepo.findByid(friendId);
        System.out.println("CURRENT USER: " + currentUser.getId());
        System.out.println("USER:" + user.getId());
        System.out.println("FRIEND ID: " + friendId);
        System.out.println("USER TO DIALOG:" + userToDialog);
        System.out.println("ROOM NAME: " + roomName);
        System.out.println("STR FRIEND TO ROOM: " + strFriendToRoom);
        //удаление из друзей
        if (!currentUser.getId().equals(user.getId())) {
            User currentUserUpdated = userRepo.findByid(currentUser.getId());

            List<User> currentFriend = currentUserUpdated.getFriendList();
            currentFriend.remove(user);
            currentUserUpdated.setFriendList(currentFriend);

            List<User> userFriend = user.getFriendList();
            userFriend.remove(currentUserUpdated);
            user.setFriendList(userFriend);

            userRepo.save(currentUserUpdated);
            userRepo.save(user);

            User updatedUser = userRepo.findByid(user.getId());

            model.addAttribute("notRootNameSelected", false);
            model.addAttribute("userToCreateDialogNotFounded", false);
            model.addAttribute("isFriend", false);
            model.addAttribute("friendList", updatedUser.getFriendList());
            model.addAttribute("friend", futureFriend);
            model.addAttribute("user", updatedUser);
            model.addAttribute("requestFriendCount", updatedUser.getFriendRequestList().size());
            model.addAttribute("respondFriendCount", updatedUser.getFriendRespondList().size());
            model.addAttribute("FriendListSize", updatedUser.getFriendList().size());
        } else {
            //создание диалога

            if (userToDialog != null
                    && userToDialog >= 1) {
                User dialogUser = userRepo.findByid(userToDialog);

                if (dialogUser == null) {
                    model.addAttribute("userToCreateDialogNotFounded", true);
                } else {
                    if (dialogUser.getId().equals(user.getId())) {
                        model.addAttribute("userToCreateDialogNotFounded", true);
                    } else {
                        Integer dialogFromFirstId = null;
                        Integer dialogFromSecondId = null;

                        for (Dialog dialog
                                : dialogRepo.findAll()) {
                            if (dialog.getFirstUser().getId().equals(user.getId())
                                    && dialog.getSecondUser().getId().equals(dialogUser.getId())) {
                                dialogFromFirstId = dialog.getId();
                            } else {
                                if (dialog.getFirstUser().getId().equals(dialogUser.getId())
                                        && dialog.getSecondUser().getId().equals(user.getId())) {
                                    dialogFromSecondId = dialog.getId();
                                }
                            }
                        }

                        if (dialogFromFirstId == null || dialogFromSecondId == null) {
                            Dialog uploadedDialogFromFirst = null;
                            Dialog uploadedDialogFromSecond = null;

                            Dialog newDialogFromFirst = new Dialog(user, dialogUser, new ArrayList<>());
                            dialogRepo.save(newDialogFromFirst);
                            uploadedDialogFromFirst = dialogRepo.findByid(newDialogFromFirst.getId());

                            Dialog newDialogFromSecond = new Dialog(dialogUser, user, new ArrayList<>());
                            dialogRepo.save(newDialogFromSecond);
                            uploadedDialogFromSecond = dialogRepo.findByid(newDialogFromSecond.getId());


                            List<Dialog> userDialogList = user.getDialogList();
                            List<Dialog> secondUserToDialogList = dialogUser.getDialogList();

                            userDialogList.add(uploadedDialogFromFirst);
                            secondUserToDialogList.add(uploadedDialogFromSecond);

                            user.setDialogList(userDialogList);
                            dialogUser.setDialogList(secondUserToDialogList);

                            userRepo.save(dialogUser);
                            userRepo.save(user);
                        }
                    }
                }
            } else {
                //добавление комнаты
                if (roomName != null && !roomName.equals("")) {
                    Room room = new Room(user, roomName);

                    if (strFriendToRoom == null){
                        List<Room> listRoomUser = user.getRooms();
                        listRoomUser.add(room);
                        user.setRooms(listRoomUser);
                        userRepo.save(user);
                        roomRepo.save(room);
                    } else {
                        String[] usernamesAdded = strFriendToRoom.split(" ");
                        List<User> userToAdded = new ArrayList<>();

                        for (int i=0; i < usernamesAdded.length; i++){
                            User usr = userRepo.findByUsername(usernamesAdded[i]);
                            if (usr != null) {
                                userToAdded.add(usr);
                                System.out.println("Guest_id: " + usr.getId());
                            }
                        }

                        List<User> paticipantUser = room.getParticipants();
                        paticipantUser.addAll(userToAdded);
                        room.setParticipants(paticipantUser);
                        roomRepo.save(room);

                        System.out.println("Get count of paticipant: " + roomRepo.findByRoomName(room.getRoomName()).getParticipants().size());

                        User[] userParticipate = new User[paticipantUser.size()];
                        for(int i = 0; i < userParticipate.length; i++)
                        {
                            User usr = paticipantUser.get(i);
                            List<Room> listRoomUser = usr.getRooms();
                            listRoomUser.add(room);
                            usr.setRooms(listRoomUser);
                            userRepo.save(usr);
                        }
                    }
                } else {
                    model.addAttribute("notRootNameSelected", true);
                }
                //добавление друга
                if (futureFriend == null) {
                    model.addAttribute("notRootNameSelected", false);
                    model.addAttribute("userToCreateDialogNotFounded", false);
                    model.addAttribute("friendList", user.getFriendList());
                    model.addAttribute("friend", null);
                    model.addAttribute("user", user);
                    model.addAttribute("requestFriendCount", user.getFriendRequestList().size());
                    model.addAttribute("respondFriendCount", user.getFriendRespondList().size());
                    model.addAttribute("FriendListSize", user.getFriendList().size());

                    return "profile";
                } else {
                    boolean alreadyInRelation = false;
                    for (User usr:
                         user.getFriendList()) {
                        if (usr.getId().equals(futureFriend.getId())){
                            alreadyInRelation = true;
                        }
                    }
                    for (User usr:
                            user.getFriendRespondList()) {
                        if (usr.getId().equals(futureFriend.getId())){
                            alreadyInRelation = true;
                        }
                    }
                    if (!alreadyInRelation && !user.getId().equals(futureFriend.getId())) {
                        List<User> listRespond = user.getFriendRespondList();
                        listRespond.add(futureFriend);

                        List<User> listRequest = futureFriend.getFriendRequestList();
                        listRequest.add(user);

                        userRepo.save(user);
                        userRepo.save(futureFriend);
                    }
                }
            }
        }
        model.addAttribute("notRootNameSelected", false);
        model.addAttribute("userToCreateDialogNotFounded", false);
        model.addAttribute("friendList", user.getFriendList());
        model.addAttribute("friend", futureFriend);
        model.addAttribute("user", user);
        model.addAttribute("requestFriendCount", user.getFriendRequestList().size());
        model.addAttribute("respondFriendCount", user.getFriendRespondList().size());
        model.addAttribute("FriendListSize", user.getFriendList().size());
        return "profile";
    }

    @GetMapping("/confirmationrequest/{user}")
    public String getConfirmation(@PathVariable("user") User user,
                                  Model model) {
        List<User> userRequest = user.getFriendRequestList();

        model.addAttribute("futureFriendRequest", userRequest);

        return "confirmationFriendRequest";
    }

    @PostMapping("/confirmationrequest/{user}")
    public String postConfirmation(@PathVariable("user") User user,
                                   @RequestParam String design,
                                   @RequestParam Long secondUser,
                                   Model model) {
        User potentialFriend = userRepo.findByid(secondUser);

        switch (design) {
            case ("add"):
                List<User> userFriend = user.getFriendList();
                List<User> potentialFriendList = potentialFriend.getFriendList();
                userFriend.add(potentialFriend);
                potentialFriendList.add(user);

                user.setFriendList(userFriend);
                potentialFriend.setFriendList(potentialFriendList);

                List<User> userRequest = user.getFriendRequestList();
                List<User> potentialFriendRespond = potentialFriend.getFriendRespondList();
                if (userRequest.contains(potentialFriend)) {
                    userRequest.remove(potentialFriend);
                    user.setFriendRequestList(userRequest);
                    potentialFriendRespond.remove(user);
                    potentialFriend.setFriendRespondList(potentialFriendRespond);
                }

                List<User> userRespond = user.getFriendRespondList();
                List<User> potentialRequest = potentialFriend.getFriendRequestList();
                if (userRespond.contains(potentialFriend)) {
                    userRespond.remove(potentialFriend);
                    user.setFriendRespondList(userRespond);
                    potentialRequest.remove(user);
                    potentialFriend.setFriendRequestList(potentialRequest);
                }
                userRepo.save(user);
                userRepo.save(potentialFriend);
                break;
            case ("reject"):
                userRequest = user.getFriendRequestList();
                potentialFriendRespond = potentialFriend.getFriendRespondList();

                if (userRequest.contains(potentialFriend)) {
                    userRequest.remove(potentialFriend);
                    user.setFriendRequestList(userRequest);
                    potentialFriendRespond.remove(user);
                    potentialFriend.setFriendRespondList(potentialFriendRespond);
                }

                userRespond = user.getFriendRespondList();
                potentialRequest = potentialFriend.getFriendRequestList();
                if (userRespond.contains(potentialFriend)) {
                    userRespond.remove(potentialFriend);
                    user.setFriendRespondList(userRespond);
                    potentialRequest.remove(user);
                    potentialFriend.setFriendRequestList(potentialRequest);
                }
                userRepo.save(user);
                userRepo.save(potentialFriend);
                break;
            case ("noting"):
                break;
        }

        List<User> userRequest = user.getFriendRequestList();

        model.addAttribute("futureFriendRequest", userRequest);

        return "confirmationFriendRequest";
    }

    @GetMapping("/respondlist/{user}")
    public String getRespond(@PathVariable("user") User user,
                             Model model) {
        List<User> userRespond = user.getFriendRespondList();

        model.addAttribute("userRespond", userRespond);

        return "respond";
    }
}
