package com.example.EventManager.controller;

import com.example.EventManager.domain.Dialog;
import com.example.EventManager.domain.DialogMessage;
import com.example.EventManager.domain.User;
import com.example.EventManager.repos.DialogMessageRepo;
import com.example.EventManager.repos.DialogRepo;
import com.example.EventManager.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class DialogController {
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private DialogRepo dialogRepo;
    @Autowired
    private DialogMessageRepo dialogMessageRepo;

    @GetMapping("/dialogs/{user}")
    public String getDialogList(@PathVariable("user") User user,
                                Model model) {
        List<Dialog> userDialogs = user.getDialogList();

        model.addAttribute("dialogs", userDialogs);
        model.addAttribute("dialogSize", userDialogs.size());

        return "dialogList";
    }

    @GetMapping("/dialog/{dialogId}/{user1}/{user2}")
    public String getDialog(@PathVariable("dialogId") Integer dialogId,
                            @PathVariable("user1") User firstUser,
                            @PathVariable("user2") User secondUser,
                            Model model) {
        Dialog newDialog;
        if (dialogId == null || dialogId < 1) {
            newDialog = new Dialog(firstUser, secondUser, new ArrayList<>());
        } else {
            newDialog = dialogRepo.findByid(dialogId);
        }
        dialogRepo.save(newDialog);
        dialogRepo.flush();

        Dialog dialog = dialogRepo.findByid(newDialog.getId());
        if (!dialog.getDialogMessageList().isEmpty()
                || dialog.getDialogMessageList() != null) {
            model.addAttribute("dialog", dialog);
            model.addAttribute("dialogSize", dialog.getDialogMessageList().size());

            model.addAttribute("user", firstUser.getId());
            model.addAttribute("target", secondUser.getId());
            model.addAttribute("dialogMessList", dialog.getDialogMessageList());
        } else {
            model.addAttribute("dialog", null);
        }
        return "dialog";
    }

    @PostMapping("/dialog/{dialogId}/{user1}/{user2}")
    public String printDialog(@RequestParam String MessageText,
                              @PathVariable("dialogId") Integer dialogId,
                              @PathVariable("user1") User firstUser,
                              @PathVariable("user2") User secondUser,
                              Model model) {
        if (dialogId == -1) {
            List<Dialog> list = dialogRepo.findAll();
            for (Dialog dialog :
                    list) {
                if (dialog.getFirstUser().getId().equals(firstUser.getId())
                        && dialog.getSecondUser().getId().equals(secondUser.getId())) {
                    dialogId = dialog.getId();
                }
            }
        }

        Dialog dialogFirst = dialogRepo.findByid(dialogId);
        if (dialogFirst.getDialogMessageList().isEmpty()
                || dialogFirst.getDialogMessageList() == null) {
            System.out.println("First was empty");
            dialogFirst.setDialogMessageList(new ArrayList<>());
        }
        List<DialogMessage> dialogMes = dialogFirst.getDialogMessageList();

        Date dateMess = new Date();
        String currentDate = dateMess.toString();

        if (MessageText.equals("")
                || MessageText == null) {
            System.out.println("GET not null");
            model.addAttribute("dialog", dialogFirst);
            model.addAttribute("dialogSize", dialogFirst.getDialogMessageList().size());

            model.addAttribute("user", firstUser.getId());
            model.addAttribute("target", secondUser.getId());
            model.addAttribute("dialogMessList", dialogFirst.getDialogMessageList());
        } else {

            DialogMessage newDialogMessage = new DialogMessage(firstUser, secondUser, MessageText);
            newDialogMessage.setDate(currentDate);

            dialogMessageRepo.save(newDialogMessage);
            dialogMessageRepo.flush();

            dialogMes.add(newDialogMessage);
            dialogFirst.setDialogMessageList(dialogMes);

            dialogRepo.save(dialogFirst);
            dialogRepo.flush();

            System.out.println("First add message(size): " + dialogRepo.findByid(dialogFirst.getId()).getDialogMessageList().size());
            System.out.println("Message from first: " + dialogMessageRepo.findByid(newDialogMessage.getId()).getText());

            Dialog secondDialog = null;
            for (Dialog dialog2 :
                    dialogRepo.findAll()) {
                if (dialog2.getFirstUser().getId().equals(secondUser.getId())
                        && dialog2.getSecondUser().getId().equals(firstUser.getId())) {
                    secondDialog = dialog2;
                    System.out.println("Found second dialog side");
                }
            }

            if (secondDialog == null) {
                System.out.println("Not Found");
                secondDialog = new Dialog(secondUser, firstUser, new ArrayList<>());
                dialogRepo.save(secondDialog);
                dialogRepo.flush();
            }

            DialogMessage newSecondDialogMessage = new DialogMessage(firstUser, secondUser, MessageText);
            newSecondDialogMessage.setDate(currentDate);
            List<DialogMessage> dialogMesSecond = secondDialog.getDialogMessageList();
            dialogMesSecond.add(newSecondDialogMessage);
            secondDialog.setDialogMessageList(dialogMesSecond);


            dialogRepo.save(secondDialog);
            dialogRepo.flush();

            dialogMessageRepo.save(newSecondDialogMessage);
            dialogMessageRepo.flush();

            System.out.println("Dialog check: " + dialogRepo.findByid(secondDialog.getId()).getId());
            System.out.println("Second add message: " + dialogMessageRepo.findByid(newSecondDialogMessage.getId()).getText());

            model.addAttribute("dialog", dialogFirst);

            model.addAttribute("dialogSize", dialogFirst.getDialogMessageList().size());
            model.addAttribute("user", firstUser.getId());
            model.addAttribute("target", secondUser.getId());
            model.addAttribute("dialogMessList", dialogFirst.getDialogMessageList());
            model.addAttribute("NewDialogMessage", newDialogMessage);
        }
        return "dialog";
    }
}
